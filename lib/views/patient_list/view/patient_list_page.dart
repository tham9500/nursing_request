import 'package:flutter/material.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class PatientListPage extends StatefulWidget {
  const PatientListPage({super.key});

  @override
  State<PatientListPage> createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomText('Patient List'),
        ),
      ),
    );
  }
}
