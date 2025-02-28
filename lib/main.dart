import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalculatorApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({Key? key}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayText = '0';    // Text shown on the display
  String _operator = '';        // +, -, *, /
  double? _firstOperand;        // Holds the first number
  double? _secondOperand;       // Holds the second number

  /// Handles number button presses (0-9).
  void _onNumberPressed(String number) {
    setState(() {
      // If display is "0" or after an operation, start fresh
      if (_displayText == '0') {
        _displayText = number;
      } else {
        _displayText += number;
      }
    });
  }