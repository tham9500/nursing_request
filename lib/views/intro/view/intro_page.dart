import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/secure_storage.dart';
import 'package:nursing_request/controller/app_info_controller.dart';
import 'package:nursing_request/views/intro/components/intro_template.dart';
import 'package:nursing_request/views/intro/controller/intro_controller.dart';
import 'package:nursing_request/views/login/view/login_page.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // ignore: unused_field
  final IntroController _introController = Get.put(IntroController());
  final AppInfoController _appInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _content(),
    );
  }

  _content() {
    return Obx(() {
      switch (_introController.currentPage.value) {
        case 0:
          return _location();

        case 1:
          return _gallery();

        case 2:
          return _storage();

        default:
          return const SizedBox();
      }
    });
  }

  _location() {
    return IntroTemplate(
      imagePath: 'location.svg',
      title: 'ตำแหน่งที่ตั้ง',
      description:
          'แอปพลิเคชันต้องการเข้าถึงตำแหน่งของคุณเพื่อใช้ในการอัพเดทตำแหน่ง',
      onTap: () async {
        var result = await Permission.location.request();

        if (result == PermissionStatus.granted) {
          _appInfoController.locationGranted(true);
        } else {
          _appInfoController.locationGranted(false);
        }

        _introController.currentPage(1);
      },
    );
  }

  _gallery() {
    return IntroTemplate(
      imagePath: 'gallery.svg',
      title: 'คลังรูปภาพ',
      description: 'แอปพลิเคชันต้องการเข้าถึงรูปภาพบนมือถือของคุณ',
      onTap: () async {
        bool useStoragePermission = false;
        if (Platform.isAndroid) {
          final androidInfo = await DeviceInfoPlugin().androidInfo;

          if (androidInfo.version.sdkInt <= 32) {
            useStoragePermission = true;
            await Permission.storage.request();
          }
        }
        await Permission.storage.request();
        await Permission.photos.request();

        PermissionStatus result;
        if (useStoragePermission) {
          result = await Permission.storage.status;
        } else {
          result = await Permission.photos.status;
        }

        if (result == PermissionStatus.granted) {
          _appInfoController.galleryGranted(true);
        } else {
          _appInfoController.galleryGranted(false);
        }

        _introController.currentPage(2);
      },
    );
  }

  _storage() {
    return IntroTemplate(
      imagePath: 'storage.svg',
      title: 'การเข้าถึงข้อมูล',
      description: 'เพื่อใช้ในการเข้าถึงไฟล์วิดีโอในการดาวน์โหลด',
      onTap: () async {
        await setInitApp('true');
        var result = await Permission.notification.request();

        if (result == PermissionStatus.granted) {
          _appInfoController.storageGranted(true);
        } else {
          _appInfoController.storageGranted(false);
        }

        Get.off(() => const LoginPage());
      },
    );
  }
}
