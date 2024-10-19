import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/widgets/custom_back_btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(onTap: () {
          Get.back();
        }),
      ),
    );
  }
}
