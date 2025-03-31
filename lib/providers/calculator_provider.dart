import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tfk_toast/enum.dart';
import 'package:tfk_toast/tfk_toast.dart';

class CalculatorProvider extends ChangeNotifier {
  String _input = '';
  String _result = '0';
  List<String> _history = [];

  String get input => _input;
  String get result => _result;
  List<String> get history => _history;

  void appendInput(String value) {
    _input += value;
    notifyListeners();
  }

  void clearInput() {
    _input = '';
    _result = '0';
    notifyListeners();
  }

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

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  double _evaluateExpression(String expression) {
    try {
      final parser = Parser();
      final formattedExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('√', 'sqrt')
          .replaceAll('log10', 'log')
          .replaceAll('ln', 'ln')
          .replaceAll('!', 'fact');

      final exp = parser.parse(formattedExpression);
      final context = ContextModel();
      return exp.evaluate(EvaluationType.REAL, context);
    } catch (e) {
      throw  TfkToast.showToast(
        "Invalid Expression",
        type: ToastType.error,
        animation: ToastAnimation.wobble,
      );
    }
  }

  void performAdvancedOperation(String function) {
    try {
      if (_input.isEmpty) {
        _result = 'Error';
        notifyListeners();
        return;
      }

      final number = double.tryParse(_input);
      if (number == null) {
        _result = 'Error';
        notifyListeners();
        return;
      }

      final result = () {
        switch (function) {
          case 'sin':
            return sin(_degreesToRadians(number));
          case 'cos':
            return cos(_degreesToRadians(number));
          case 'tan':
            return tan(_degreesToRadians(number));
          case 'log10':
            return log(number) / ln10;
          case 'ln':
            return log(number);
          case '√':
            return sqrt(number);
          case '!':
            return factorial(number);
          default:
            throw TfkToast.showToast(
              "Unsupported Function $function",
              type: ToastType.error,
              animation: ToastAnimation.wobble,
            );
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

  double _degreesToRadians(double degrees) => degrees * pi / 180;
  double factorial(double n) {
    if (n < 0 || n != n.floorToDouble()) {
      throw TfkToast.showToast(
        "Factorial is defined for non-negative integers only",
        type: ToastType.warning,
        animation: ToastAnimation.wobble,
      );
    }
    return (n == 0)
        ? 1
        : List.generate(n.toInt(), (i) => i + 1)
            .fold(1, (a, b) => a * b)
            .toDouble();
  }
}
