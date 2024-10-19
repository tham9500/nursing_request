import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<String?> getInitApp() async {
  return await storage.read(key: 'onInitApp');
}

setInitApp(String value) async {
  await storage.write(key: 'onInitApp', value: value);
}

