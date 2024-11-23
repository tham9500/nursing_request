import 'dart:developer';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:nursing_request/views/login/view/login_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AppInfoController extends GetxController {
  var appName = ''.obs;
  var appVersion = ''.obs;
  var model = ''.obs;
  var os = ''.obs;
  var uuid = ''.obs;

  var cameraGranted = false.obs;
  var micriphoneGranted = false.obs;
  var galleryGranted = false.obs;
  var notificationGranted = false.obs;
  var storageGranted = false.obs;
  var locationGranted = false.obs;
  String connectionUrl = '';
  String connectionUsername = '';
  String connectionPassword = '';
  var db;
  var collectionUser;

  getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String name = packageInfo.appName;
    appVersion('$version ($buildNumber)');
    appName(name);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String osVersion =
          'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';

      const androidIdPlugin = AndroidId();
      final String? androidID = await androidIdPlugin.getId();
      // Android 8 and above, the Android ID is not unique per device, but also per signing key the app was built with
      // https://stackoverflow.com/questions/4799394/is-secure-android-id-unique-for-each-device/43393373#43393373

      model(androidInfo.model);
      uuid(androidID);
      os(osVersion);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      model(iosInfo.utsname.machine.iOSProductName);
      os('${iosInfo.systemName} ${iosInfo.systemVersion}');
      uuid(iosInfo.identifierForVendor);
    }

    const storage = FlutterSecureStorage();
    await storage.write(key: 'uuid', value: uuid.value);
  }

  checkPermission() async {
    if (await Permission.notification.isGranted) {
      notificationGranted(true);
    } else {
      notificationGranted(false);
    }
    if (await Permission.camera.isGranted) {
      cameraGranted(true);
    } else {
      cameraGranted(false);
    }

    bool useStoragePermission = false;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        useStoragePermission = true;
      }
    }

    if (useStoragePermission) {
      if (await Permission.storage.isGranted) {
        galleryGranted(true);
      } else {
        galleryGranted(false);
      }
    } else {
      if (await Permission.photos.isGranted) {
        galleryGranted(true);
      } else {
        galleryGranted(false);
      }
    }

    if (await Permission.location.isGranted) {
      locationGranted(true);
    } else {
      locationGranted(false);
    }
  }

  String appInfoDataForClipboard() {
    String modelString = 'อุปกรณ์: ${model.value}';
    String osString = 'ระบบ: ${os.value}';
    String uuidString = 'รหัสอุปกรณ์: ${uuid.value}';
    String appVersionString = 'แอปเวอร์ชั่น: ${appVersion.value}';

    return '$modelString\n$osString\n$uuidString\n$appVersionString';
  }

  getENV() async {
    await dotenv.load();
    connectionUrl = dotenv.get('mongoDB');
    connectionUsername = dotenv.get('id');
    connectionPassword = dotenv.get('password');
  }

  connectDB() async {
    db = await Db.create(connectionUrl);
    await db.open();
    inspect(db);
    collectionUser = db.collection("user_data");
    log('DB Open');
  }

  onLogout() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.delete(key: 'status');
    await storage.delete(key: 'error');
    await storage.delete(key: 'msg');
    await storage.delete(key: 'token');
    await storage.delete(key: 'company_id');
    await storage.delete(key: 'raw_data_visibility_node');
    await storage.delete(key: 'data_visibility_node');
    await storage.delete(key: 'vehicle_list');
    await storage.delete(key: 'location_list');
    await storage.delete(key: 'vehicle_group_list');
    await storage.delete(key: 'permissions');
    await storage.delete(key: 'location_group_list');
    await storage.delete(key: 'user_history_logon_id');
    await storage.delete(key: 'exp');

    //todo Remove on PRD
    // await storage.deleteAll();

    Get.offAll(() => const LoginPage());
  }
}
