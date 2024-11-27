import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Color titleColor;
  final double? contentFontSize;
  final double? buttonFontSize;
  final String? content;
  final Color buttonColor;
  final Function()? onOK;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    this.contentFontSize,
    this.buttonFontSize,
    this.content,
    this.buttonColor = Colors.grey,
    this.onOK,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title,
              color: titleColor,
              size: contentFontSize ?? 24.0,
              weight: FontWeight.bold,
              align: TextAlign.center,
            ),
            Visibility(
              visible: content != null,
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  CustomText(
                    content ?? '',
                    color: Colors.grey,
                    size: 16.0,
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();

                if (onOK != null) {
                  onOK!();
                }
              },
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Center(
                  child: CustomText(
                    'ตกลง',
                    size: buttonFontSize ?? 14.0,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Center(
                  child: CustomText(
                    'ยกเลิก',
                    size: buttonFontSize ?? 14.0,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
