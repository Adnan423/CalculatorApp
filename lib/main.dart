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

  /// Handles operation button presses (+, -, *, /).
  void _onOperatorPressed(String op) {
    setState(() {
      // Convert current display text to first operand
      _firstOperand = double.tryParse(_displayText);
      _operator = op;
      // Reset display to prepare for second operand
      _displayText = '0';
    });
  }

  /// Handles = and does the math
  void _onEqualsPressed() {
    setState(() {
      _secondOperand = double.tryParse(_displayText);

      if (_firstOperand == null || _secondOperand == null || _operator.isEmpty) {
        // If something is missing, do nothing or handle gracefully
        return;
      }

      double result = 0;
      switch (_operator) {
        case '+':
          result = _firstOperand! + _secondOperand!;
          break;
        case '-':
          result = _firstOperand! - _secondOperand!;
          break;
        case '*':
          result = _firstOperand! * _secondOperand!;
          break;
        case '/':
          if (_secondOperand == 0) {
            // Handle divide by zero case
            _displayText = 'Error';
            _firstOperand = null;
            _secondOperand = null;
            _operator = '';
            return;
          } else {
            result = _firstOperand! / _secondOperand!;
          }
          break;
        default:
          break;
      }
      // Update display with result
      _displayText = _formatResult(result);
      // Reset for next calculation
      _firstOperand = null;
      _secondOperand = null;
      _operator = '';
    });
  }

  /// Formatting for correct decimal placement
  String _formatResult(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  /// Clear to clear the calculator of any numbers
  void _onClearPressed() {
    setState(() {
      _displayText = '0';
      _operator = '';
      _firstOperand = null;
      _secondOperand = null;
    });
  }

  /// Calculator button with text and a callback
  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,                // Button’s background color
            foregroundColor: Colors.white,         // Text color
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(fontSize: 24),
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CalculatorApp'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Display area
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Buttons
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7', Colors.blueGrey, () => _onNumberPressed('7')),
                  _buildButton('8', Colors.blueGrey, () => _onNumberPressed('8')),
                  _buildButton('9', Colors.blueGrey, () => _onNumberPressed('9')),
                  _buildButton('/', Colors.deepOrange, () => _onOperatorPressed('/')),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Colors.blueGrey, () => _onNumberPressed('4')),
                  _buildButton('5', Colors.blueGrey, () => _onNumberPressed('5')),
                  _buildButton('6', Colors.blueGrey, () => _onNumberPressed('6')),
                  _buildButton('*', Colors.deepOrange, () => _onOperatorPressed('*')),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Colors.blueGrey, () => _onNumberPressed('1')),
                  _buildButton('2', Colors.blueGrey, () => _onNumberPressed('2')),
                  _buildButton('3', Colors.blueGrey, () => _onNumberPressed('3')),
                  _buildButton('-', Colors.deepOrange, () => _onOperatorPressed('-')),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', Colors.blueGrey, () => _onNumberPressed('0')),
                  _buildButton('C', Colors.redAccent, _onClearPressed),
                  _buildButton('+', Colors.deepOrange, () => _onOperatorPressed('+')),
                  _buildButton('=', Colors.green, _onEqualsPressed),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}