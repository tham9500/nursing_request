import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/controller/app_info_controller.dart';
import 'package:nursing_request/widgets/custom_dialog.dart';

class RegisterController extends GetxController {
  AppInfoController appInfoController = Get.find();
  String connectionUrl = '';
  String connectionUsername = '';
  String connectionPassword = '';
  late Db db;
  verifyRegister(
      {required String username,
      required String password,
      required String repassword,
      required String firstname,
      required String lastname,
      required String id}) async {
    if (id == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'หมายเลขประจำตัว',
          buttonColor: primaryColor,
        ),
      );
    }

    if (username == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกชื่อผู้ใช้',
          buttonColor: primaryColor,
        ),
      );
    }

    if (firstname == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกชื่อ',
          buttonColor: primaryColor,
        ),
      );
    }
    if (lastname == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกนามสกุล',
          buttonColor: primaryColor,
        ),
      );
    }

    if (password == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกรหัสผ่าน',
          buttonColor: primaryColor,
        ),
      );
    }

    if (repassword != password) {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกรัหสผ่านให้ถูกต้อง',
          buttonColor: primaryColor,
        ),
      );
    } else {
      await registerDB(
        username: username,
        password: password,
        repassword: repassword,
        firstname: firstname,
        lastname: lastname,
        id: id,
      );
    }
  }

  registerDB(
      {required String username,
      required String password,
      required String repassword,
      required String firstname,
      required String lastname,
      required String id}) async {
    try {
      print('call register');
      // var response = collection.find({
      //   'username': username,
      //   'firstname': firstname,
      //   'lastname': lastname,
      //   'id': id
      // });
      var data = await appInfoController.db.collection('user_data').find();
      print(data);
    } catch (e) {
      print("error -> $e");
    }
  }
}
