import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_submit_btn.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class IntroTemplate extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Function() onTap;

  const IntroTemplate({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 144.0,
                        backgroundColor: Colors.grey.shade200,
                        child: SvgPicture.asset(
                          'assets/images/$imagePath',
                          width: 114.0,
                          height: 114.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: marginX2),
                    CustomText(
                      title,
                      size: fontSizeXL,
                      weight: FontWeight.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: CustomText(
                        description,
                        size: fontSizeL,
                        color: Colors.grey,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(marginX2),
                child: CustomSubmitButton(
                  onTap: onTap,
                  title: 'ถัดไป',
                  color: primaryColor,
                  borderRadius: 16.0,
                  isGradient: true,
                  gradientColor1: Colors.pink.shade500,
                  gradientColor2: Colors.pink.shade100,
                  buttonHeight: 54.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
