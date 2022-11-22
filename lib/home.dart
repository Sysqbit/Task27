import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SysqbitCalculator extends StatefulWidget {
  const SysqbitCalculator({super.key});

  @override
  SysqbitCalculatorState createState() => SysqbitCalculatorState();
}

class SysqbitCalculatorState extends State<SysqbitCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "0";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        expression = equation;
        expression.replaceAll('×', '*');
        expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              // ignore: prefer_const_constructors
              side: BorderSide(
                  color: const Color.fromARGB(255, 108, 101, 101),
                  width: 1,
                  style: BorderStyle.solid)),
        )),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sysqbit Calculator')),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          // ignore: prefer_const_constructors
          padding: EdgeInsets.fromLTRB(
            12,
            20,
            10,
            0,
          ),
          child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          // ignore: prefer_const_constructors
          padding: EdgeInsets.fromLTRB(
            12,
            20,
            10,
            0,
          ),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        const Expanded(child: Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(children: [
                    buildButton("C", 1, Colors.redAccent),
                    buildButton("⌫", 1, Colors.blue),
                    buildButton("÷", 1, Colors.blue)
                  ]),
                  TableRow(children: [
                    buildButton("7", 1, Colors.black54),
                    buildButton("8", 1, Colors.black54),
                    buildButton("9", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton("4", 1, Colors.black54),
                    buildButton("5", 1, Colors.black54),
                    buildButton("6", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton("1", 1, Colors.black54),
                    buildButton("2", 1, Colors.black54),
                    buildButton("3", 1, Colors.black54),
                  ]),
                  TableRow(children: [
                    buildButton(".", 1, Colors.black54),
                    buildButton("0", 1, Colors.black54),
                    buildButton("00", 1, Colors.black54),
                  ])
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blue),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.redAccent),
                    ]),
                  ],
                ))
          ],
        )
      ]),
    );
  }
}
