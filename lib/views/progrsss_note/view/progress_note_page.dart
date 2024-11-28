import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/views/progrsss_note/controller/progress_note_controller.dart';
import 'package:nursing_request/widgets/custom_dialog.dart';
import 'package:nursing_request/widgets/custom_loading.dart';
import 'package:nursing_request/widgets/custom_submit_btn.dart';
import 'package:nursing_request/widgets/custom_text.dart';
import 'package:nursing_request/widgets/custom_text_area.dart';
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
  var loading = true.obs;

  @override
  void initState() {
    // TODO: implement initState
    prepareData();
    super.initState();
  }

  prepareData() {
    progressNoteController.onAddPage();
    progressNoteController.content = progressNoteController.page[0]['content'];
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
    }
    loading.value = false;
    setState(() {});
  }

  setCurrentdata(int index) {
    loading.value = true;
    dateShift.clear();
    time.clear();
    focus.clear();
    note.clear();
    name.clear();
    // progressNoteController.content.clear();

    patientName.text =
        progressNoteController.page[currentIndex]['profile']['patient'];
    age.text = progressNoteController.page[currentIndex]['profile']['age'];
    hn.text = progressNoteController.page[currentIndex]['profile']['hn'];
    an.text = progressNoteController.page[currentIndex]['profile']['an'];
    department.text =
        progressNoteController.page[currentIndex]['profile']['department'];
    attending.text =
        progressNoteController.page[currentIndex]['profile']['attending'];
    ward.text = progressNoteController.page[currentIndex]['profile']['ward'];
    progressNoteController.content =
        progressNoteController.page[currentIndex]['content'];
    print(progressNoteController.page[currentIndex]['content'].length);
    for (int i = 0;
        i < progressNoteController.page[currentIndex]['content'].length;
        i++) {
      dateShift.add(TextEditingController());
      dateShift[i].text =
          progressNoteController.page[currentIndex]['content'][i]['date'];
      time.add(TextEditingController());
      time[i].text =
          progressNoteController.page[currentIndex]['content'][i]['time'];
      focus.add(TextEditingController());
      focus[i].text =
          progressNoteController.page[currentIndex]['content'][i]['focus'];
      note.add(TextEditingController());
      note[i].text =
          progressNoteController.page[currentIndex]['content'][i]['note'];
      name.add(TextEditingController());
      name[i].text =
          progressNoteController.page[currentIndex]['content'][i]['name'];
    }

    loading.value = false;
    setState(() {});
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

  removePage(int index) {
    loading.value = true;
    progressNoteController.onRemovePage(index);
    loading.value = false;
    setState(() {});
  }

  clearAllData() {
    Get.dialog(
      CustomAlertDialog(
        title: 'เตือน',
        content: 'ต้องการเคลียร์ข้อมูลทั้งหมดหรือไม่',
        onOK: () {
          progressNoteController.page.clear();
          progressNoteController.profile = {};
          progressNoteController.content.clear();
          prepareData();
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      clearAllData();
                    },
                    child: Container(
                      width: 100,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red.shade200,
                      ),
                      child: const Center(
                        child: CustomText(
                          'New Reset',
                          size: fontSizeXL,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: margin,
                  ),
                  Container(
                    width: 100,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.shade300,
                    ),
                    child: Center(
                      child: CustomText(
                        'หน้า ${currentIndex + 1}/${progressNoteController.page.length}',
                        size: fontSizeXL,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
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
                              setCurrentdata(index);

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
                                      : Colors.white10,
                                ),
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: [
                                    progressNoteController.page.length == 1
                                        ? Container()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.all(margin),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  print('Action remove page');
                                                  removePage(index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: textColorWhite,
                                                ),
                                              ),
                                            ),
                                          ),
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
                            printer(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _loading(),
        ],
      ),
    );
  }

  _profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16, left: 16, bottom: 0),
              child: CustomText(
                'ข้อมูลผู้ป่วย',
                size: fontSizeXXXL,
                weight: FontWeight.bold,
              ),
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
                          'ชื่อผู้ป่วย',
                          size: fontSizeXXL,
                        ),
                        CustomTextField(
                          bgColor: Colors.white,
                          controller: patientName,
                          labelText: 'ชื่อผู้ป่วย',
                          onChanged: (value) {
                            // patientName.text = value;
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
                          bgColor: Colors.white,
                          controller: age,
                          labelText: 'อายุ',
                          onChanged: (value) {
                            // age.text = value;
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
                          bgColor: Colors.white,
                          controller: hn,
                          labelText: 'HN',
                          onChanged: (value) {
                            // hn.text = value;
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
                          bgColor: Colors.white,
                          controller: an,
                          labelText: 'AN',
                          onChanged: (value) {
                            // an.text = value;
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
                          bgColor: Colors.white,
                          controller: department,
                          labelText: 'Department of Service',
                          onChanged: (value) {
                            // department.text = value;
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
                          bgColor: Colors.white,
                          controller: attending,
                          labelText: 'Attending Physician',
                          onChanged: (value) {
                            // attending.text = value;
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
                          bgColor: Colors.white,
                          controller: ward,
                          labelText: 'Ward',
                          onChanged: (value) {
                            // ward.text = value;
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
      ),
    );
  }

  _textField(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, bottom: 0),
              child: CustomText(
                'Focus ${index + 1}',
                size: fontSizeXXXL,
                weight: FontWeight.bold,
              ),
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
                          'Date/Shift',
                          size: fontSizeXXL,
                        ),
                        CustomTextField(
                          bgColor: Colors.white,
                          controller: dateShift[index],
                          labelText: 'Date/Shift',
                          onChanged: (value) {
                            // dateShift[index].text = value;
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
                          bgColor: Colors.white,
                          controller: time[index],
                          labelText: 'Time',
                          onChanged: (value) {
                            // time[index].text = value;
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
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
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
            SizedBox(
              width: Get.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomTextField(
                  bgColor: Colors.white,
                  controller: focus[index],
                  labelText: 'Focus',
                  onChanged: (value) {
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomText(
                'Progress',
                size: fontSizeXL,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomTextFieldArea(
                      bgColor: Colors.white,
                      maxLine: 10,
                      maxLength: 1000,
                      controller: note[index],
                      labelText: '',
                      onChanged: (value) {
                        // note[index].text = value;
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
                CustomText(
                  '${note[index].text.length}/1000',
                  color: textColorGrey,
                )
              ],
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
                  bgColor: Colors.white,
                  controller: name[index],
                  labelText: 'Name',
                  onChanged: (value) {
                    // name[index].text = value;
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
      ),
    );
  }

  addContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.25,
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

  printer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: Get.width * 0.25,
        child: CustomSubmitButton(
          onTap: () async {
            log(jsonEncode(progressNoteController.page));
            final pdf = await createPdf();
            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdf.save(),
            );
            await Printing.sharePdf(
              bytes: await pdf.save(),
              filename: '${DateTime.now}.pdf',
            );
          },
          title: 'พิมพ์',
        ),
      ),
    );
  }

  Future<pw.Document> createPdf() async {
    final pdf = pw.Document();
    final fontData = await rootBundle
        .load('assets/fonts/SukhumvitSet/SukhumvitSet-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);
    for (int i = 0; i < progressNoteController.page.length; i++) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Text('Rajavithi Hospital - Nursing Progress Note',
                    style: pw.TextStyle(
                        font: ttf,
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      pw.Container(
                        width: 64,
                        child: pw.Column(
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.all(4),
                              child: pw.Text(
                                'Date/Shift',
                                textAlign: pw.TextAlign.left,
                                maxLines: 1,
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            // pw.Padding(
                            //   padding: const pw.EdgeInsets.all(8),
                            //   child: pw.Text(
                            //     'Shift',
                            //     style: pw.TextStyle(
                            //       fontWeight: pw.FontWeight.normal,
                            //       fontSize: 10,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      pw.Container(
                        width: 52,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Time',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 72,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Focus',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 200,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Progress Note',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 56,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Name',
                            textAlign: pw.TextAlign.left,
                            maxLines: 1,
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    // Add empty rows as needed
                    for (int j = 0;
                        j < progressNoteController.page[i]['content'].length;
                        j++)
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            progressNoteController.page[i]['content'][j]
                                ['date'],
                            maxLines: 1,
                            textAlign: pw.TextAlign.left,
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              progressNoteController.page[i]['content'][j]
                                  ['time'],
                              maxLines: 1,
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                font: ttf,
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              progressNoteController.page[i]['content'][j]
                                  ['focus'],
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                font: ttf,
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            )),
                        pw.Container(
                          width: 200,
                          child: pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Text(
                                progressNoteController.page[i]['content'][j]
                                    ['note'],
                                textAlign: pw.TextAlign.start,
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              )),
                        ),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              progressNoteController.page[i]['content'][j]
                                  ['name'],
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(
                                font: ttf,
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            )),
                      ]),
                  ],
                ),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(children: [
                      pw.Container(
                        width: 100,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Name ${progressNoteController.page[i]['profile']['patient'] ?? '...................'}  Age ${progressNoteController.page[i]['profile']['age'] ?? '...................'}',
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                'HN ${progressNoteController.page[i]['profile']['hn'] ?? '...................'}  AN ${progressNoteController.page[i]['profile']['an'] ?? '...................'}',
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                'Ward ${progressNoteController.page[i]['profile']['ward'] ?? '...................'}',
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                              pw.Text(
                                'Print/Name Label',
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(children: [
                          pw.Text(
                            'Department of Service',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          pw.Text(
                            '${progressNoteController.page[i]['profile']['department'] ?? '..............................'}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          pw.Text(
                            'Attending Physician',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                          pw.Text(
                            '${progressNoteController.page[i]['profile']['attending'] ?? '..............................'}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 10,
                            ),
                          ),
                        ]),
                      ),
                    ]),
                    // Add empty rows as needed
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    return pdf;
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: loading.value,
        child: const CustomLoading(
          color: primaryColor,
        ),
      );
    });
  }
}
