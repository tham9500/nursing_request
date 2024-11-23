import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/views/register/controller/register_controller.dart';
import 'package:nursing_request/widgets/custom_submit_btn.dart';
import 'package:nursing_request/widgets/custom_text.dart';
import 'package:nursing_request/widgets/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscurePassword = true;
  bool obscureRePassword = true;
  RegisterController registerController = Get.put(RegisterController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
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
                  'Register',
                  size: 56.0,
                  weight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.height * 0.6,
                ),
                child: const CustomText(
                  'Nurse Progress Register',
                  size: 24.0,
                ),
              ),
              _cardInput(),
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
                controller: _idController,
                labelText: 'ID',
              ),
              const SizedBox(height: marginX2),
              CustomTextField(
                controller: _usernameController,
                labelText: 'User Name',
              ),
              const SizedBox(height: marginX2),
              CustomTextField(
                controller: _firstnameController,
                labelText: 'ชื่อ',
              ),
              const SizedBox(height: marginX2),
              CustomTextField(
                controller: _lastnameController,
                labelText: 'นามสกุล',
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
              const SizedBox(height: marginX2),
              CustomTextField(
                controller: _rePasswordController,
                labelText: 'ยืนยันรหัสผ่าน',
                obscureText: obscureRePassword,
                suffix: InkWell(
                  onTap: () {
                    obscureRePassword = !obscureRePassword;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: margin),
                    child: Icon(
                      obscureRePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: obscureRePassword
                          ? Colors.grey.shade400
                          : primaryColor,
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

  _registerButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.height * 0.6,
      ),
      child: CustomSubmitButton(
        onTap: () async {
          registerController.verifyRegister(
            username: _usernameController.text,
            password: _passwordController.text,
            repassword: _rePasswordController.text,
            firstname: _firstnameController.text,
            lastname: _lastnameController.text,
            id: _idController.text,
          );
        },
        title: 'ลงทะเบียน',
        color: primaryColor,
        borderRadius: 10.0,
        isGradient: true,
        gradientColor1: primaryColor,
        gradientColor2: secondaryColor,
      ),
    );
  }
}
