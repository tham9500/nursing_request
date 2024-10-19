import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class CustomLoading extends StatefulWidget {
  final Color color;

  const CustomLoading({
    super.key,
    this.color = Colors.grey,
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  String label = '';

  @override
  void initState() {
    super.initState();
    _getLocale();
  }

  _getLocale() {
    if (Get.locale == const Locale('th_TH') ||
        Get.locale == const Locale('th')) {
      label = 'กำลังโหลด';
    } else if (Get.locale == const Locale('en_EN') ||
        Get.locale == const Locale('en')) {
      label = 'Loading';
    } else {
      label = 'กำลังโหลด';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black12,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: widget.color,
              ),
              const SizedBox(height: marginX2),
              CustomText(
                label,
                color: Colors.black,
                weight: FontWeight.bold,
                size: fontSizeM,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
