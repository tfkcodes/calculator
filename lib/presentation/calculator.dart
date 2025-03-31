import 'package:calculator/presentation/widgets/result_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String activeSubject = 'Mathematics';

  final List<String> subjects = [
    'Economics',
    'Mathematics',
    'Physics',
    'History',
    'Community',
  ];
  bool _showMoreFunctions = false;

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text('Dike Calculator'),
        actions: [
          IconButton(
            onPressed: calculatorProvider.clearHistory,
            icon: const Icon(Icons.delete),
            tooltip: 'Clear History',
          ),
          IconButton(
            onPressed: () => _showHistoryBottomSheet(context),
            icon: const Icon(Icons.history),
            tooltip: 'View History',
          ),
        ],
      ),
      body: Column(
        children: [
          ResultDisplay(calculatorProvider: calculatorProvider),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildKeypadRow(
                  context,
                  ['Clear', 'sin', 'cos', 'tan','^'],
                  isAdvanced: true,
                ),
                _buildKeypadRow(
                  context,
                  ['log10', 'ln', '√', '!','More'],
                  isAdvanced: true,
                ),
                if (_showMoreFunctions)...[
                  _buildKeypadRow(
                    context,
                    ['(', ')', 'π', 'mod','e',],
                    isAdvanced: true,
                  ),
                  _buildKeypadRow(
                    context,
                    ['asin', 'acos','atan','sinh'],
                    isAdvanced: true,
                  ),
                  _buildKeypadRow(
                    context,
                    [ 'cosh', 'tanh','exp','abs',],
                    isAdvanced: true,
                  ),
                  _buildKeypadRow(
                    context,
                    [ 'floor', 'nPr','nCr','LCM',],
                    isAdvanced: true,
                  ),
                ]
               ,
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

  Widget _buildKeypadRow(BuildContext context, List<String> keys,
      {bool isAdvanced = false, bool isMoreButton = false}) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys.map((key) {
          return ElevatedButton(
            onPressed: () {
              if (key == 'More') {
                setState(() {
                  _showMoreFunctions = !_showMoreFunctions;
                });
              }
                if (key == 'Clear') {
                calculatorProvider.clearInput();
              } else if (key == '=') {
                calculatorProvider.calculateResult();
              } else if (isAdvanced) {
                calculatorProvider.performAdvancedOperation(key);
              } else {
                calculatorProvider.appendInput(key);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(60, 50),
              backgroundColor: getBgColor(key, context),
            ),
            child: Text(
              key,
              style: TextStyle(
                fontSize: 20,
                color: getTextColor(key, context),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showHistoryBottomSheet(BuildContext context) {
    final history = Provider.of<CalculatorProvider>(context, listen: false).history;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.transparent, // Transparent background for glass effect
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Calculation History',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              if (history.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "No history available",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                )
              else
                Expanded(
                  // height: 300,
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.calculate, color: Colors.black54),
                          ),
                          title: Text(
                            history[index],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                label: const Text("Close"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Color getBgColor(String key, BuildContext context) {
    if (key == 'Clear') {
      return Theme.of(context).colorScheme.error;
    }  if (key == 'More') {
      return Theme.of(context).colorScheme.primary;
    }
    else if (key == '=') {
      return Theme.of(context).colorScheme.primary;
    } else if (['sin', 'cos', 'tan', 'log10', 'ln', '√', '!','cosh', 'tanh','exp','abs','floor', 'nPr','nCr','LCM','asin', 'acos','atan','sinh','(', ')', 'π', 'mod','e'].contains(key)) {
      return Theme.of(context).colorScheme.secondary;
    }
    return Theme.of(context).cardColor;
  }

  Color getTextColor(String key, BuildContext context) {
    if (key == 'Clear') {
      return Theme.of(context).colorScheme.onError;
    }
    if (key == 'More') {
      return Theme.of(context).colorScheme.surface;
    }
    else if (key == '=') {
      return Theme.of(context).colorScheme.onPrimary;
    }
    return Theme.of(context).colorScheme.surface;
  }
}
