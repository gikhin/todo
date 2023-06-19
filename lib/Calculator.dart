import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    'AC', '(', ')', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '+',
    '1', '2', '3', '-',
    'C', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: () {
        handleButton(text);
      },
      child: Ink(
        decoration: BoxDecoration(
         // color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColour(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color getColour(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  void handleButton(String text) {
    setState(() {
      if (text == "AC") {
        userInput = "";
        result = "0";
      } else if (text == "C") {
        if (userInput.isNotEmpty) {
          userInput = userInput.substring(0, userInput.length - 1);
        }
      } else if (text == "=") {
        result = calculate();
        userInput = result;
        if (result.endsWith(".0")) {
          result = result.replaceAll(".0", "");
        }
      } else {
        userInput += text;
      }
    });
  }

  String calculate() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(userInput);

      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);

      if (eval % 1 == 0) {
        return eval.toInt().toString();
      } else {
        return eval.toString();
      }
    } catch (e) {
      return "Error";
    }
  }
}


