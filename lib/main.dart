// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:sysqbitcalculator/home.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SysqbitCalculator(),
    );
  }
}
