import 'package:flutter/material.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class FocusListPage extends StatefulWidget {
  const FocusListPage({super.key});

  @override
  State<FocusListPage> createState() => _FocusListPageState();
}

class _FocusListPageState extends State<FocusListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Center(
            child: CustomText('Focus List'),
          ),
        ),
      ),
    );
  }
}
