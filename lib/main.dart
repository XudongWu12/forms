import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'form_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Example',
      home: FormWidget(
        initialValues: {
          'doubleValue': 5.0,
          'stringValue': 'Hello',
          'radioValue': RadioOptions.option1,
          'checkbox1': true,
          'checkbox2': false,
          'checkbox3': true,
          'dropdownValue': User('First0', 'Last0'),
        },
      ),
    );
  }
}