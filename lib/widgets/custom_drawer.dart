import 'package:flutter/material.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  final String? menu;
  final Function() select1;
  final String? label1;
  final Widget? icon1;
  final Function() select2;
  final String? label2;
  final Widget? icon2;
  final Function() select3;
  final String? label3;
  final Widget? icon3;

  const CustomDrawer({
    super.key,
    required this.menu,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.select1,
    required this.select2,
    required this.select3,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: CustomText(
              menu ?? '',
              size: 36,
            ),
          ),
          ListTile(
            title: CustomText(
              label1 ?? '',
              size: 18.0,
            ),
            onTap: select1,
          ),
          ListTile(
            title: CustomText(
              label2 ?? '',
              size: 18.0,
            ),
            onTap: select2,
          ),
          ListTile(
            title: CustomText(
              label3 ?? '',
              size: 18.0,
            ),
            onTap: select3,
          ),
        ],
      ),
    );
  }
}
