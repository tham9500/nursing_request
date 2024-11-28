import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/controller/navigation_controller.dart';
import 'package:nursing_request/views/focus_list/view/focus_list_pasge.dart';
import 'package:nursing_request/views/patient_list/view/patient_list_page.dart';
import 'package:nursing_request/views/progrsss_note/controller/progress_note_controller.dart';
import 'package:nursing_request/views/progrsss_note/view/progress_note_page.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NavigationController navigationController = Get.find();
  ProgressNoteController progressNoteController =
      Get.put(ProgressNoteController());
  @override
  void initState() {
    navigationController.title = 'Nurse Progress Note';
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List page = [
      const ProgressNotePage(),
      // const FocusListPage(),
      // const PatientListPage(),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: CustomText(
          navigationController.title,
          color: textColorWhite,
          size: fontSizeXXXL,
        ),
      ),
      body: page[navigationController.currentIndex.value],
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: customBoxShadow,
      //     borderRadius: const BorderRadius.only(
      //       topRight: Radius.circular(25.0),
      //       topLeft: Radius.circular(25.0),
      //     ),
      //   ),
      //   child: SafeArea(
      //     child: SizedBox(
      //       height: navigationBarHeight,
      //       child: BottomNavigationBar(
      //         type: BottomNavigationBarType.fixed,
      //         backgroundColor: Colors.transparent,
      //         elevation: 0.0,
      //         selectedItemColor: Colors.black,
      //         unselectedItemColor: Colors.grey.shade400,
      //         selectedFontSize: fontSizeXXL,
      //         unselectedFontSize: fontSizeXL,
      //         currentIndex: navigationController.currentIndex.value,
      //         onTap: (index) {
      //           navigationController.currentIndex.value = index;
      //           switch (index) {
      //             case 0:
      //               navigationController.title = 'Nurse Progress Note';

      //               break;
      //             case 1:
      //               navigationController.title = 'Focus List';

      //               break;
      //             case 2:
      //               navigationController.title = 'Bed';

      //               break;
      //             default:
      //           }
      //           setState(() {});
      //         },
      //         items: [
      //           BottomNavigationBarItem(
      //             icon: Icon(
      //               Icons.note,

      //               size: 48.0,
      //               // ignore: deprecated_member_use
      //               color: navigationController.currentIndex.value == 0
      //                   ? Colors.black
      //                   : Colors.grey.shade400,
      //             ),
      //             label: 'Nurse Note',
      //             tooltip: '',
      //           ),
      //           // BottomNavigationBarItem(
      //           //   icon: Icon(
      //           //     Icons.center_focus_strong,
      //           //     color: navigationController.currentIndex.value == 1
      //           //         ? Colors.black
      //           //         : Colors.grey.shade400,
      //           //     size: 48.0,
      //           //   ),
      //           //   label: 'Focus List',
      //           //   tooltip: '',
      //           // ),
      //           // BottomNavigationBarItem(
      //           //   icon: Icon(
      //           //     Icons.bed,
      //           //     // ignore: deprecated_member_use
      //           //     color: navigationController.currentIndex.value == 2
      //           //         ? Colors.black
      //           //         : Colors.grey.shade400,
      //           //     size: 48.0,
      //           //   ),
      //           //   label: 'เตียงผู้ป่วย',
      //           //   tooltip: '',
      //           // ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
