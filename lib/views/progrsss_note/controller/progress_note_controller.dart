import 'dart:developer';

import 'package:get/get.dart';

class ProgressNoteController extends GetxController {
  var profile = {
    "patient": '',
    "age": '',
    "hn": '',
    "an": '',
    "department": '',
    "attending": '',
    "ward": '',
  };
  List<dynamic> page = [];
  List<dynamic> content = [];

  addContent(
      {required String patient,
      required String age,
      required String hn,
      required String an,
      required String department,
      required String attending,
      required String ward,
      required String date,
      required String time,
      required String focus,
      required String note,
      required String name}) {
    profile = {
      "patient": patient,
      "age": age,
      "hn": hn,
      "an": an,
      "department": department,
      "attending": attending,
      "ward": ward,
    };
    content.add({
      "date": date,
      "time": time,
      "focus": focus,
      "note": note,
      "name": name,
    });
  }

  addFocus(
      {required String date,
      required String time,
      required String focus,
      required String note,
      required String name,
      required int index}) {
    content.add({
      "date": '',
      "time": '',
      "focus": '',
      "note": '',
      "name": '',
    });
    page[index]['content'] = content;
  }

  removeFocus({required int indexPage, required int indeContent}) {
    content.removeAt(indeContent);
    page[indexPage]['content'] = content;
  }

  onAddPage() {
    page.add({
      'profile': profile,
      'content': [
        {
          "date": '',
          "time": '',
          "focus": '',
          "note": '',
          "name": '',
        }
      ]
    });
  }

  onSaveProfile({
    required String patient,
    required String age,
    required String hn,
    required String an,
    required String department,
    required String attending,
    required String ward,
  }) {
    profile = {
      "patient": patient,
      "age": age,
      "hn": hn,
      "an": an,
      "department": department,
      "attending": attending,
      "ward": ward,
    };
    log(profile.toString());
  }

  saveAllProfile() async {
    for (int i = 0; i < page.length; i++) {
      page[i]['profile'] = profile;
    }
  }

  onRemovePage(int index) {
    page.removeAt(index);
  }

  updateFocus(
      {required String date,
      required String time,
      required String focus,
      required String note,
      required String name,
      required int indexPage,
      required int indexContent}) {
    print(content);
    content[indexContent] = {
      "date": date,
      "time": time,
      "focus": focus,
      "note": note,
      "name": name,
    };
    page[indexPage]['content'] = content;
    print(page[indexPage]['content']);
  }
}
