
import 'package:flutter/material.dart';

import '../../providers/calculator_provider.dart';

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({
    super.key,
    required this.calculatorProvider,
  });

  final CalculatorProvider calculatorProvider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10, top: 10),
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
                padding: const EdgeInsets.only(right: 10, top: 10),
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    calculatorProvider.result,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
