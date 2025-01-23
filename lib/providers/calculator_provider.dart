import 'dart:math';
import 'package:flutter/material.dart';

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
    final exp = expression.replaceAll('×', '*').replaceAll('÷', '/');
    return _parseAndEvaluate(exp);
  }

  double _parseAndEvaluate(String expression) {
    final result = double.parse(expression); 
    return result;
  }
}
