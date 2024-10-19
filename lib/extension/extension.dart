import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String yyyyMMddHHmmss() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  String formattedString({String format = 'dd/MM/yy HH:mm'}) {
    return DateFormat(format).format(this);
  }

  bool isSameDay(DateTime? date) {
    if (date == null) {
      return false;
    }

    return date.year == year && date.month == month && date.day == day;
  }

  DateTime startOfTheDay() {
    return DateTime(year, month, day, 0, 0, 0);
  }

  DateTime endOfTheDay() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  String durationString() {
    String result = 'now'.tr;

    DateTime currentTime = DateTime.now();
    int minutes = currentTime.difference(this).inMinutes;
    int hours = currentTime.difference(this).inHours;
    int days = currentTime.difference(this).inDays;
    int months = (days / 30).floor();

    if (months >= 1) {
      result = '$months ${'months ago'.tr}';
    } else if (days >= 1) {
      result = '$days ${'days ago'.tr}';
    } else if (hours >= 1) {
      result = '$hours ${'hours ago'.tr}';
    } else if (minutes >= 1) {
      result = '$minutes ${'minutes ago'.tr}';
    }

    return result;
  }
}

extension MonthInt on int {
  String monthName(bool isAbbr) {
    switch (this) {
      case 1:
        return isAbbr ? 'jan.'.tr : 'january'.tr;

      case 2:
        return isAbbr ? 'feb.'.tr : 'february'.tr;

      case 3:
        return isAbbr ? 'mar.'.tr : 'march'.tr;

      case 4:
        return isAbbr ? 'apr.'.tr : 'april'.tr;

      case 5:
        return isAbbr ? 'may.'.tr : 'may'.tr;

      case 6:
        return isAbbr ? 'jun.'.tr : 'june'.tr;

      case 7:
        return isAbbr ? 'jul.'.tr : 'july'.tr;

      case 8:
        return isAbbr ? 'aug.'.tr : 'august'.tr;

      case 9:
        return isAbbr ? 'sep.'.tr : 'september'.tr;

      case 10:
        return isAbbr ? 'oct.'.tr : 'october'.tr;

      case 11:
        return isAbbr ? 'nov.'.tr : 'november'.tr;

      case 12:
        return isAbbr ? 'dec.'.tr : 'december'.tr;

      default:
        return '';
    }
  }

  String dayName(bool isAbbr) {
    switch (this) {
      case 0:
        return isAbbr ? 'sun.'.tr : 'sunday'.tr;

      case 1:
        return isAbbr ? 'mon.'.tr : 'monday'.tr;

      case 2:
        return isAbbr ? 'tue.'.tr : 'tuesday'.tr;

      case 3:
        return isAbbr ? 'wed.'.tr : 'wednesday'.tr;

      case 4:
        return isAbbr ? 'thu.'.tr : 'thursday'.tr;

      case 5:
        return isAbbr ? 'fri.'.tr : 'friday'.tr;

      case 6:
        return isAbbr ? 'sat.'.tr : 'saturday'.tr;

      default:
        return '';
    }
  }
}

extension StringExtension on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\“]+(\.[^<>()[\]\\.,;:\s@\“]+)*)|(\“.+\“))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPhone() {
    return RegExp(
        r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
        .hasMatch(this);
  }

  Map<String, dynamic> parseJWT() {
    final parts = split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}