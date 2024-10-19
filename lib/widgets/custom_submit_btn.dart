import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class CustomSubmitButton extends StatelessWidget {
  final String testKey;
  final Function() onTap;
  final double buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry buttonMargin;
  final EdgeInsetsGeometry buttonPadding;
  final String title;
  final double fontSize;
  final Color color;
  final Color fontColor;
  final BoxBorder? border;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Widget? prefixIcon;
  final bool avoidSafeArea;
  final bool isGradient;
  final Color? gradientColor1;
  final Color? gradientColor2;

  const CustomSubmitButton({
    super.key,
    this.testKey = '',
    required this.onTap,
    this.buttonHeight = 50.0,
    this.buttonWidth,
    this.buttonMargin = EdgeInsets.zero,
    this.buttonPadding = const EdgeInsets.symmetric(vertical: 10.0),
    required this.title,
    this.fontSize = fontSizeL,
    this.color = Colors.grey,
    this.fontColor = Colors.white,
    this.border,
    this.borderRadius = 25.0,
    this.boxShadow,
    this.prefixIcon,
    this.avoidSafeArea = false,
    this.isGradient = false,
    this.gradientColor1,
    this.gradientColor2,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: avoidSafeArea,
      child: InkWell(
        key: ValueKey(testKey),
        onTap: onTap,
        child: Container(
          height: buttonHeight,
          width: buttonWidth ?? Get.width,
          padding: buttonPadding,
          margin: buttonMargin,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            boxShadow: boxShadow,
            gradient: isGradient
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      gradientColor1 ?? Colors.grey,
                      gradientColor2 ?? Colors.grey.shade300,
                    ],
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: prefixIcon != null,
                child: Row(
                  children: [
                    prefixIcon ?? const SizedBox(),
                    const SizedBox(width: margin),
                  ],
                ),
              ),
              CustomText(
                title,
                size: fontSize,
                color: fontColor,
                weight: FontWeight.bold,
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
