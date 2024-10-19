import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/views/login/controller/login_controller.dart';
import 'package:nursing_request/views/register/view/register_page.dart';
import 'package:nursing_request/widgets/custom_submit_btn.dart';
import 'package:nursing_request/widgets/custom_text.dart';
import 'package:nursing_request/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.put(LoginController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 246, 159, 220),
              Color.fromARGB(255, 249, 214, 243)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.height * 0.6,
                ),
                child: const CustomText(
                  'Login',
                  size: 56.0,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.height * 0.6,
                ),
                child: const CustomText(
                  'Nurse Progress Requestment',
                  size: 24.0,
                ),
              ),
              _cardInput(),
              _loginButton(),
              const SizedBox(
                height: 8.0,
              ),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  _cardInput() {
    return Center(
      child: Column(
        children: [
          _textField(),
        ],
      ),
    );
  }

  _textField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height * 0.025,
        horizontal: Get.height * 0.6,
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.width * 0.012,
            horizontal: Get.width * 0.012,
          ),
          child: Column(
            children: [
              CustomTextField(
                controller: _usernameController,
                labelText: 'ชื่อผู้ใช้',
              ),
              const SizedBox(height: marginX2),
              CustomTextField(
                controller: _passwordController,
                labelText: 'รหัสผ่าน',
                obscureText: obscurePassword,
                suffix: InkWell(
                  onTap: () {
                    obscurePassword = !obscurePassword;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: margin),
                    child: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color:
                          obscurePassword ? Colors.grey.shade400 : primaryColor,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.height * 0.6,
      ),
      child: CustomSubmitButton(
        onTap: () async {
          await _loginController.verifyLogin(
              _usernameController.text, _passwordController.text);
        },
        title: 'เข้าสู่ระบบ',
        color: primaryColor,
        borderRadius: 10.0,
        isGradient: true,
        gradientColor1: primaryColor,
        gradientColor2: secondaryColor,
      ),
    );
  }

  _registerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.height * 0.6,
      ),
      child: CustomSubmitButton(
        onTap: () async {
          Get.to(() => const RegisterPage());
        },
        title: 'ลงทะเบียน',
        fontColor: textColorBlack,
        color: Colors.transparent,
        border: Border.all(width: 0.5, color: primaryColor),
        borderRadius: 10.0,
        isGradient: false,
      ),
    );
  }
}
