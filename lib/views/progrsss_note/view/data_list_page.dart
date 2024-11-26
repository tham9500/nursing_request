import 'package:flutter/material.dart';
import 'package:nursing_request/widgets/custom_text.dart';

class DataListPage extends StatefulWidget {
  const DataListPage({super.key});

  @override
  State<DataListPage> createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText('Nurse Progress Note'),
      ),
    );
  }
}
