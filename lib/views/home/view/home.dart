import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/controller/navigation_controller.dart';
import 'package:nursing_request/views/focus_list/view/focus_list_pasge.dart';
import 'package:nursing_request/views/patient_list/view/patient_list_page.dart';
import 'package:nursing_request/views/progrsss_note/view/progress_note_page.dart';
import 'package:nursing_request/widgets/custom_drawer.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    List page = [
      const ProgressNotePage(),
      const FocusListPage(),
      const PatientListPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const CustomText(
          'Home Page',
          size: 24,
          color: textColorWhite,
        ),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(
        menu: 'Main Menu',
        icon1: const Icon(
          Icons.note,
          color: primaryColor,
        ),
        icon2: const Icon(
          Icons.center_focus_strong,
          color: primaryColor,
        ),
        icon3: const Icon(
          Icons.edit,
          color: primaryColor,
        ),
        label1: 'Nurse Progress Note',
        label2: 'Focus List',
        label3: 'Patient List',
        select1: () {
          navigationController.currentIndex.value = 0;
          setState(() {});
          Scaffold.of(context).closeDrawer();
        },
        select2: () {
          navigationController.currentIndex.value = 1;
          setState(() {});
          Scaffold.of(context).closeDrawer();
        },
        select3: () {
          navigationController.currentIndex.value = 2;
          setState(() {});
          Scaffold.of(context).closeDrawer();
        },
      ),
      body: page[navigationController.currentIndex.value],
    );
  }
}
