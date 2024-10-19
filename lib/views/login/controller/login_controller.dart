import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_dialog.dart';

class LoginController extends GetxController {
  verifyLogin(String username, String password) async {
    if (username == '') {
      return Get.dialog(
        const CustomAlertDialog(
          title: 'กรุณากรอกชื่อผู้ใช้',
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

    await login(username, password);
  }

  login(String username, String password) async {}
}
