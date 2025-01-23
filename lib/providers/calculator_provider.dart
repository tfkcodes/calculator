import 'dart:math';
import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = '';
  String _result = '0';
  List<String> _history = [];

  String get input => _input;
  String get result => _result;
  List<String> get history => _history;

  /// Appends a value (number or operator) to the input
  void appendInput(String value) {
    _input += value;
    notifyListeners();
  }

  /// Clears the current input and result
  void clearInput() {
    _input = '';
    _result = '0';
    notifyListeners();
  }

  /// Calculates the result of the current input
  void calculateResult() {
    try {
      if (_input.isNotEmpty) {
        final parsedResult = _evaluateExpression(_input);
        _result = parsedResult.toString();
        _history.add('$_input = $_result');
        notifyListeners();
      }
    } catch (e) {
      _result = 'Error';
      notifyListeners();
    }
  }

  /// Clears the history of calculations
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  /// Evaluates the given expression
  double _evaluateExpression(String expression) {
    // Replace symbols for easier evaluation
    final exp = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('√', 'sqrt')
        .replaceAll('^', '**'); // Handle power
    return _parseAndEvaluate(exp);
  }

  /// Parses and evaluates mathematical expressions
  double _parseAndEvaluate(String expression) {
    try {
      // Handle basic arithmetic
      final result = _evaluateArithmetic(expression);
      return result;
    } catch (e) {
      throw Exception('Invalid Expression');
    }
  }

  /// Evaluates basic arithmetic operations
  double _evaluateArithmetic(String expression) {
    // Using basic parsing logic (expandable for advanced parsing)
    final tokens = expression.split(RegExp(r'([+\-*/%()√^])'));
    double? result;
    String operator = '';

    for (var token in tokens) {
      token = token.trim();
      if (token.isEmpty) continue;

      // Check if the token is an operator
      if (['+', '-', '*', '/', '%', '^'].contains(token)) {
        operator = token;
        continue;
      }

      // Parse the number
      final number = double.tryParse(token);
      if (number == null) {
        throw Exception('Invalid number: $token');
      }

      // Perform the operation
      if (result == null) {
        result = number;
      } else {
        result = _performOperation(result, number, operator);
      }
    }

    return result ?? 0.0;
  }

  /// Performs a specific operation
  double _performOperation(double a, double b, String operator) {
    switch (operator) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        if (b == 0) throw Exception('Cannot divide by zero');
        return a / b;
      case '%':
        return a % b;
      case '^':
        return pow(a, b).toDouble();
      default:
        throw Exception('Unsupported operator: $operator');
    }
  }

  /// Advanced Functions
  double factorial(double n) {
    if (n < 0 || n != n.floorToDouble()) {
      throw Exception('Factorial is defined for non-negative integers only');
    }
    return (n == 0)
        ? 1
        : List.generate(n.toInt(), (i) => i + 1)
            .fold(1, (a, b) => a * b)
            .toDouble();
  }

  double squareRoot(double n) {
    if (n < 0)
      throw Exception('Cannot calculate square root of a negative number');
    return sqrt(n);
  }

  double sinValue(double degrees) => sin(_degreesToRadians(degrees));
  double cosValue(double degrees) => cos(_degreesToRadians(degrees));
  double tanValue(double degrees) => tan(_degreesToRadians(degrees));

  double log10Value(double n) {
    if (n <= 0)
      throw Exception('Logarithm is defined for positive numbers only');
    return log(n) / ln10;
  }

  double naturalLog(double n) {
    if (n <= 0)
      throw Exception('Natural logarithm is defined for positive numbers only');
    return log(n);
  }

  double _degreesToRadians(double degrees) => degrees * pi / 180;

  void performAdvancedOperation(String function) {
    try {
      if (_input.isEmpty) {
        _result = 'Error';
        notifyListeners();
        return;
      }

      final number = double.parse(_input);

      final result = () {
        switch (function) {
          case 'sin':
            return sinValue(number);
          case 'cos':
            return cosValue(number);
          case 'tan':
            return tanValue(number);
          case 'log10':
            return log10Value(number);
          case 'ln':
            return naturalLog(number);
          case 'sqrt':
            return squareRoot(number);
          case 'factorial':
            return factorial(number);
          default:
            throw Exception('Unsupported function: $function');
        }
      }();

      _result = result.toString();
      _history.add('$function($_input) = $_result');
      notifyListeners();
    } catch (e) {
      _result = 'Error';
      notifyListeners();
    }
  }
}
