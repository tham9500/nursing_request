import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:nursing_request/constant/secure_storage.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/controller/app_info_controller.dart';
import 'package:nursing_request/views/home/view/home.dart';
import 'package:nursing_request/views/login/view/login_page.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppInfoController _appInfoController = Get.put(AppInfoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appInfoController.getDeviceInfo();
    _delay();
  }

  _delay() async {
    await _appInfoController.getENV();
    await Future.delayed(const Duration(seconds: 2));

    String? login = await getLogin();

    if (login != null) {
      Get.offAll(() => const HomePage());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(margin),
              height: 96.0,
              width: 96.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(margin),
                color: Colors.pink.shade300,
              ),
              child: Image.asset('assets/logo/nurse.png'),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomText(
              'Nurse Progress',
              size: fontSizeXXL,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 440),
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            _appVersion(),
          ],
        ),
      ),
    );
  }

  _appVersion() {
    return Obx(() {
      return CustomText(
        'VERSION ${_appInfoController.appVersion.value}',
        align: TextAlign.center,
        size: fontSizeM,
        weight: FontWeight.bold,
        color: textColorGrey,
      );
    });
  }
}
