import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/views/progrsss_note/controller/progress_note_controller.dart';
import 'package:nursing_request/widgets/custom_submit_btn.dart';
import 'package:nursing_request/widgets/custom_text.dart';
import 'package:nursing_request/widgets/custom_textfield.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ProgressNotePage extends StatefulWidget {
  const ProgressNotePage({super.key});

  @override
  State<ProgressNotePage> createState() => _ProgressNotePageState();
}

class _ProgressNotePageState extends State<ProgressNotePage> {
  ProgressNoteController progressNoteController = Get.find();
  List<TextEditingController> dateShift = [];
  List<TextEditingController> time = [];
  List<TextEditingController> focus = [];
  List<TextEditingController> note = [];
  List<TextEditingController> name = [];
  ////
  final TextEditingController patientName = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController hn = TextEditingController();
  final TextEditingController an = TextEditingController();
  final TextEditingController department = TextEditingController();
  final TextEditingController ward = TextEditingController();
  final TextEditingController attending = TextEditingController();
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    prepareData();
    super.initState();
  }

  prepareData() {
    progressNoteController.onAddPage();
    for (int i = 0; i < progressNoteController.page[0]['content'].length; i++) {
      dateShift.add(TextEditingController());
      dateShift[i].text = progressNoteController.page[0]['content'][0]['date'];
      time.add(TextEditingController());
      time[i].text = progressNoteController.page[0]['content'][0]['time'];
      focus.add(TextEditingController());
      focus[i].text = progressNoteController.page[0]['content'][0]['focus'];
      note.add(TextEditingController());
      note[i].text = progressNoteController.page[0]['content'][0]['note'];
      name.add(TextEditingController());
      name[i].text = progressNoteController.page[0]['content'][0]['name'];
      setState(() {});
    }
  }

  setCurrentdata(int index) {
    dateShift.clear();
    time.clear();
    focus.clear();
    note.clear();
    name.clear();
    progressNoteController.content.clear();

    patientName.text =
        progressNoteController.page[index][index]['profile']['patient'];
    age.text = progressNoteController.page[index]['profile']['age'];
    hn.text = progressNoteController.page[index]['profile']['hn'];
    an.text = progressNoteController.page[index]['profile']['an'];
    department.text =
        progressNoteController.page[index]['profile']['department'];
    ward.text = progressNoteController.page[index]['profile']['attending'];
    attending.text = progressNoteController.page[index]['profile']['ward'];
    progressNoteController.content =
        progressNoteController.page[index]['content'];
    for (int i = 0;
        i < progressNoteController.page[index]['content'].length;
        i++) {
      dateShift.add(TextEditingController());
      dateShift[i].text = progressNoteController.page[index]['content']['date'];
      time.add(TextEditingController());
      time[i].text = progressNoteController.page[index]['content']['time'];
      focus.add(TextEditingController());
      focus[i].text = progressNoteController.page[index]['content']['focus'];
      note.add(TextEditingController());
      note[i].text = progressNoteController.page[index]['content']['note'];
      name.add(TextEditingController());
      name[i].text = progressNoteController.page[index]['content']['name'];
      setState(() {});
    }
  }

  addFocus(int index) {
    progressNoteController.addFocus(
        date: '', time: '', focus: '', note: '', name: '', index: index);
    dateShift.add(TextEditingController());
    time.add(TextEditingController());
    focus.add(TextEditingController());
    note.add(TextEditingController());
    name.add(TextEditingController());
    setState(() {});
  }

  removeFocus(int index) {
    progressNoteController.removeFocus(
      indexPage: currentIndex,
      indeContent: index,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Container(
            width: Get.width * 0.15,
            height: Get.height,
            color: Colors.grey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: progressNoteController.page.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          currentIndex = index;
                          await progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == index
                                  ? Colors.white54
                                  : Colors.white38,
                            ),
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                Center(
                                  child: CustomText(
                                    (index + 1).toString(),
                                    size: fontSizeXXL,
                                    color: textColorWhite,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      progressNoteController.onAddPage();
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38,
                        ),
                        width: Get.width * 0.15,
                        height: 50,
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: textColorWhite,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(margin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _profile(),
                    const Divider(
                      color: textColorGrey,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: progressNoteController
                          .page[currentIndex]['content'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return _textField(index);
                      },
                    ),
                    Row(
                      children: [
                        addContent(),
                        print(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'ชื่อผู้ป่วย',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: patientName,
                        labelText: 'ชื่อผู้ป่วย',
                        onChanged: (value) {
                          patientName.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'อายุ',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: age,
                        labelText: 'อายุ',
                        onChanged: (value) {
                          age.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'HN',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: hn,
                        labelText: 'HN',
                        onChanged: (value) {
                          hn.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'AN',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: an,
                        labelText: 'AN',
                        onChanged: (value) {
                          an.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Department of Service',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: department,
                        labelText: 'Department of Service',
                        onChanged: (value) {
                          department.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Attending Physician',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: attending,
                        labelText: 'Attending Physician',
                        onChanged: (value) {
                          attending.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Ward',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: ward,
                        labelText: 'Ward',
                        onChanged: (value) {
                          ward.text = value;
                          progressNoteController.onSaveProfile(
                            patient: patientName.text,
                            age: age.text,
                            hn: hn.text,
                            an: an.text,
                            department: department.text,
                            attending: attending.text,
                            ward: ward.text,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _textField(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Date/Shift',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: dateShift[index],
                        labelText: 'Date/Shift',
                        onChanged: (value) {
                          dateShift[index].text = value;
                          progressNoteController.updateFocus(
                            date: dateShift[index].text,
                            time: time[index].text,
                            focus: focus[index].text,
                            note: note[index].text,
                            name: name[index].text,
                            indexPage: currentIndex,
                            indexContent: index,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.22,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        'Time',
                        size: fontSizeXXL,
                      ),
                      CustomTextField(
                        controller: time[index],
                        labelText: 'Time',
                        onChanged: (value) {
                          time[index].text = value;
                          progressNoteController.updateFocus(
                            date: dateShift[index].text,
                            time: time[index].text,
                            focus: focus[index].text,
                            note: note[index].text,
                            name: name[index].text,
                            indexPage: currentIndex,
                            indexContent: index,
                          );
                          progressNoteController.saveAllProfile();
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              progressNoteController.page[currentIndex]['content'].length == 1
                  ? Container()
                  : SizedBox(
                      width: Get.width * 0.05,
                      child: CustomSubmitButton(
                        onTap: () {
                          removeFocus(index);
                        },
                        title: 'ลบ',
                        color: Colors.transparent,
                        fontColor: Colors.red,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomText(
              'Focus',
              size: fontSizeXL,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              controller: focus[index],
              labelText: 'Focus',
              onChanged: (value) {
                focus[index].text = value;
                progressNoteController.updateFocus(
                  date: dateShift[index].text,
                  time: time[index].text,
                  focus: focus[index].text,
                  note: note[index].text,
                  name: name[index].text,
                  indexPage: currentIndex,
                  indexContent: index,
                );
                progressNoteController.saveAllProfile();
                setState(() {});
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomText(
              'Progress',
              size: fontSizeXL,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              maxLine: 10,
              controller: note[index],
              labelText: '',
              onChanged: (value) {
                note[index].text = value;
                progressNoteController.updateFocus(
                  date: dateShift[index].text,
                  time: time[index].text,
                  focus: focus[index].text,
                  note: note[index].text,
                  name: name[index].text,
                  indexPage: currentIndex,
                  indexContent: index,
                );
                progressNoteController.saveAllProfile();
                setState(() {});
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomText(
              'Name',
              size: fontSizeXL,
            ),
          ),
          SizedBox(
            width: Get.width * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                controller: name[index],
                labelText: 'Name',
                onChanged: (value) {
                  name[index].text = value;
                  progressNoteController.updateFocus(
                    date: dateShift[index].text,
                    time: time[index].text,
                    focus: focus[index].text,
                    note: note[index].text,
                    name: name[index].text,
                    indexPage: currentIndex,
                    indexContent: index,
                  );
                  progressNoteController.saveAllProfile();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  addContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.3,
        child: CustomSubmitButton(
          onTap: () {
            addFocus(currentIndex);
          },
          title: 'เพิ่ม Focus',
          color: textColorWhite,
          fontColor: primaryColor,
          border: Border.all(
            width: 0.5,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  print() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.3,
        child: CustomSubmitButton(
          onTap: () async {
            log(jsonEncode(progressNoteController.page));
            // final pdf = await createPdf();
            // await Printing.layoutPdf(
            //   onLayout: (PdfPageFormat format) async => pdf.save(),
            // );
            // await Printing.sharePdf(
            //   bytes: await pdf.save(),
            //   filename: 'example.pdf',
            // );
          },
          title: 'พิมพ์',
        ),
      ),
    );
  }

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              'Hello, Flutter!',
              style: const pw.TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
