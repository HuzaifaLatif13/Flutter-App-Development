import 'package:calculator/components.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var previousInput = '';
  var previousResult = '';
  var userInput = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Center(
                    child: Text('Huzaifa\'s Calculator',
                        style: TextStyle(fontSize: 28, color: Colors.orange)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                previousInput == ''
                                    ? ' '
                                    : '$previousInput = $previousResult',
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white70)),
                            const SizedBox(height: 10),
                            Text(
                              userInput.toString(),
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.white),
                            ),
                            Text(
                              result.toString(),
                              style: const TextStyle(
                                  fontSize: 40, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 14,
                    endIndent: 15,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  buildButtonRow(['AC', '+/-', 'Ans', '/']),
                  buildButtonRow(['7', '8', '9', 'x']),
                  buildButtonRow(['4', '5', '6', '-']),
                  buildButtonRow(['1', '2', '3', '+']),
                  buildButtonRow(['0', '.', 'DEL', '=']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> titles) {
    return Expanded(
      child: Row(
        children: titles.map((title) {
          return MyButton(
            title: title,
            onPress: () {
              onButtonPress(title);
            },
            color: getColor(title),
          );
        }).toList(),
      ),
    );
  }

  void onButtonPress(String title) {
    setState(() {
      if (title == 'AC') {
        userInput = '';
        result = '';
      } else if (title == 'DEL') {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (title == '=') {
        equalPress();
        previousInput = userInput;
        previousResult = result;
      } else if (title == 'Ans') {
        userInput = previousResult;
      } else {
        userInput += title == 'x' ? '*' : title;
      }
    });
  }

  Color getColor(String title) {
    if (['/', 'x', '-', '+', '='].contains(title)) {
      return Colors.orange;
    }
    return Colors.grey;
  }

  void equalPress() {
    try {
      String finaluserInput = userInput.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finaluserInput);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      if (eval == eval.toInt()) {
        result = eval.toInt().toString();
      } else {
        result = eval.toString();
      }
    } catch (e) {
      result = 'Error';
    }
  }
}
