import 'package:flutter/material.dart';
import 'package:nursing_request/constant/value_constant.dart';

class CustomBackButton extends StatelessWidget {
  final String testKey;
  final Function() onTap;
  final bool showCircle;
  final double? height;
  final double? outerRadius;
  final double? innerRadius;
  final bool showBorder;
  final Color borderColor;
  final bool showShadow;
  final Widget? icon;
  final Color? iconColor;
  final double? iconCircleSize;
  final double? iconSize;

  const CustomBackButton({
    super.key,
    this.testKey = '',
    required this.onTap,
    this.showCircle = false,
    this.height,
    this.outerRadius,
    this.innerRadius,
    this.showBorder = false,
    this.borderColor = Colors.grey,
    this.showShadow = false,
    this.icon,
    this.iconColor,
    this.iconCircleSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      key: ValueKey(testKey),
      child: showCircle
          ? CircleAvatar(
              radius: outerRadius ?? 20.0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: height ?? 32.0,
                width: height ?? 32.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(innerRadius ?? 18.0),
                  border: showBorder ? Border.all(color: borderColor) : null,
                  boxShadow: showShadow ? customBoxShadow : null,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: innerRadius ?? 18.0,
                  child: icon ??
                      Icon(
                        Icons.navigate_before_rounded,
                        color: iconColor ?? Colors.black,
                        size: iconCircleSize ?? 25.0,
                      ),
                ),
              ),
            )
          : icon ??
              Icon(
                Icons.navigate_before,
                color: iconColor ?? Colors.black,
                size: iconSize ?? 30.0,
              ),
    );
  }
}
