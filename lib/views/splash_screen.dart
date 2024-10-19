import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/controller/app_info_controller.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppInfoController _appInfoController = Get.put(AppInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 72.0,
              width: 72.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(margin),
                color: Colors.pink.shade300,
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
