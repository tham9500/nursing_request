import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> getInitApp() async {
  return await storage.read(key: 'onInitApp');
}

setInitApp(String value) async {
  await storage.write(key: 'onInitApp', value: value);
}

Future<String?> getLogin() async {
  return await storage.read(key: 'login');
}

// ignore: body_might_complete_normally_nullable
Future<String?> setLogin(String value) async {
  await storage.write(key: 'login', value: value);
}

// ignore: body_might_complete_normally_nullable
Future<String?> deleteLogIn() async {
  await storage.delete(key: 'login');
}

