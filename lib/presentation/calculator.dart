import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
        actions: [
          IconButton(
            onPressed: () => calculatorProvider.clearHistory(),
            icon: const Icon(Icons.delete),
            tooltip: 'Clear History',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        calculatorProvider.input,
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        calculatorProvider.result,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Keypad
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildKeypadRow(
                  context,
                  ['C', 'sin', 'cos', 'tan'],
                ),
                _buildKeypadRow(
                  context,
                  ['7', '8', '9', '÷'],
                ),
                _buildKeypadRow(
                  context,
                  ['4', '5', '6', '×'],
                ),
                _buildKeypadRow(
                  context,
                  ['1', '2', '3', '-'],
                ),
                _buildKeypadRow(
                  context,
                  ['0', '.', '=', '+'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(BuildContext context, List<String> keys) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) {
          return ElevatedButton(
            onPressed: () {
              if (key == 'C') {
                calculatorProvider.clearInput();
              } else if (key == '=') {
                calculatorProvider.calculateResult();
              } else {
                calculatorProvider.appendInput(key);
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 50),
                backgroundColor: getBgColor(key, context)),
            child: Text(
              key,
              style: TextStyle(
                fontSize: 24,
                color: getTextColor(key, context),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color getBgColor(String key, BuildContext context) {
    if (key == 'C') {
      return Theme.of(context).colorScheme.error;
    } else if (key == '=') {
      return Theme.of(context).colorScheme.primary;
    } else if (key == 'sin' || key == 'cos' || key == 'tan') {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).cardColor;
  }

  Color getTextColor(String key, BuildContext context) {
    if (key == 'C') {
      return Theme.of(context).colorScheme.onError;
    } else if (key == '=') {
      return Theme.of(context).colorScheme.onPrimary;
    }
    return Theme.of(context).colorScheme.surface;
  }
}
