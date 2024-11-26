import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';

class ProgressNoteController extends GetxController {
  Map<String, dynamic> profile = {};
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
      required String name}) {
    content.add({
      "date": date,
      "time": time,
      "focus": focus,
      "note": note,
      "name": name,
    });
  }

  removeFocus(int index) {
    content.removeAt(index);
  }

  onAddPage() {
    page.add({
      'profile': profile,
      'content': {
        "date": '',
        "time": '',
        "focus": '',
        "note": '',
        "name": '',
      }
    });
  }

  onSaveProfile({
    String? patient,
    String? age,
    String? hn,
    String? an,
    String? department,
    String? attending,
    String? ward,
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
      print(page[i]['profile']);
      print(profile);
      page[i]['profile'] = profile;
    }
  }

  onRemovePage(int index) {
    page.removeAt(index);
  }

  deleteNote(int index) {}
}