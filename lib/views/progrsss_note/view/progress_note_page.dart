import 'package:flutter/material.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class ProgressNotePage extends StatefulWidget {
  const ProgressNotePage({super.key});

  @override
  State<ProgressNotePage> createState() => _ProgressNotePageState();
}

class _ProgressNotePageState extends State<ProgressNotePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomText('progress note'),
        ),
      ),
    );
  }
}
