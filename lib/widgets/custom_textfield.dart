import 'package:flutter/material.dart';
import 'package:nursing_request/constant/value_constant.dart';

class CustomTextField extends StatelessWidget {
  final String testKey;
  final bool isEnabled;
  final bool isRequired;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? prefixHint;
  final String labelText;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final int maxLine;
  final TextInputType inputType;
  final FloatingLabelBehavior validate;
  final Color? bgColor;

  const CustomTextField({
    Key? key,
    this.testKey = '',
    this.isEnabled = true,
    this.isRequired = true,
    this.obscureText = false,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.prefixHint = 'กรุณาใส่',
    this.labelText = '',
    this.prefix,
    this.suffix,
    this.maxLength,
    this.maxLine = 1,
    this.inputType = TextInputType.text,
    this.validate = FloatingLabelBehavior.auto,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: ValueKey(testKey),
      enabled: isEnabled,
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
      style: const TextStyle(
        color: textColorBlack,
        fontSize: fontSizeL,
        fontFamily: 'SukhumvitSet',
      ),
      decoration: InputDecoration(
        filled: bgColor == null ? false : true,
        fillColor: bgColor ?? textColorWhite,
        counterText: '',
        floatingLabelBehavior: validate,
        labelStyle: TextStyle(
          color: focusNode != null && focusNode!.hasFocus
              ? primaryColor
              : Colors.black45,
        ),
        hintText: validate == FloatingLabelBehavior.always
            ? '$prefixHint$labelText'
            : null,
        hintStyle: const TextStyle(
          color: Colors.red,
          fontSize: fontSizeL,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: const EdgeInsets.only(
          left: marginX2,
          right: marginX2,
          top: 12.0,
          bottom: 12.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              labelText,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: fontSizeM,
              ),
            ),
            Visibility(
              visible: isRequired,
              child: const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  suffix!,
                  Visibility(
                    visible: suffix != null,
                    child: const SizedBox(width: margin),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
