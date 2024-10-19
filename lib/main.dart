import 'package:flutter/material.dart';
import 'package:nursing_request/constant/value_constant.dart';
import 'package:nursing_request/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nursing Progress',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: primaryColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: 'SukhumvitSet',
      ),
      home: const SplashScreen(),
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        // ignore: deprecated_member_use
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.2);

        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        );
      },
    );
  }
}
