import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<List> symbols = [
    ['sin', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['cos', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['tan', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['log', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['ln', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['C', const Color.fromRGBO(43, 162, 76, 1), Colors.white],
    ['Del', const Color.fromRGBO(228, 62, 43, 1), Colors.white],
    ['%', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['/', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['*', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['9', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['8', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['7', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['6', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['+', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['5', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['4', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['3', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['2', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['-', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['1', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['0', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['.', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['Ans', const Color.fromRGBO(245, 245, 245, 1), Colors.black],
    ['^', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['(', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    [')', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['√', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
    ['pi', const Color.fromRGBO(240, 181, 1, 1), Colors.white],
    ['=', const Color.fromRGBO(59, 125, 237, 1), Colors.white],
  ];
  String input = '';
  String output = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            child: Text(
              input,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            child: Text(
              output,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(240, 181, 1, 1),
              ),
            ),
          ),
          GridView.builder(
              itemCount: symbols.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (symbols[index][0] == 'C') {
                      setState(() {
                        input = '';
                        output = '';
                      });
                    } else if (symbols[index][0] == 'Del') {
                      setState(() {
                        input = input.substring(0, input.length - 1);
                      });
                    } else if (symbols[index][0] == 'Ans') {
                      setState(() {
                        input = output;
                        output = '';
                      });
                    } else if (symbols[index][0] == '%' ||
                        symbols[index][0] == '/' ||
                        symbols[index][0] == '*' ||
                        symbols[index][0] == '+' ||
                        symbols[index][0] == '-') {
                      if (input.endsWith('%') ||
                          input.endsWith('/') ||
                          input.endsWith('*') ||
                          input.endsWith('+') ||
                          input.endsWith('-')) {
                        null;
                      } else {
                        setState(() {
                          input += symbols[index][0];
                        });
                      }
                    } else if (symbols[index][0] == '=') {
                      Expression exp = Parser().parse(input);
                      double result =
                          exp.evaluate(EvaluationType.REAL, ContextModel());
                      setState(() {
                        output = result.toString();
                      });
                    } else if (symbols[index][0] == 'sin' ||
                        symbols[index][0] == 'cos' ||
                        symbols[index][0] == 'tan') {
                      setState(() {
                        input += '${symbols[index][0]}((3.14/180)*';
                      });
                    } else if (symbols[index][0] == 'pi') {
                      setState(() {
                        input += '3.14';
                      });
                    } else if (symbols[index][0] == 'log' ||
                        symbols[index][0] == 'ln' ||
                        symbols[index][0] == '√') {
                      null;
                    } else {
                      setState(() {
                        input += symbols[index][0];
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: symbols[index][1],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      symbols[index][0],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: symbols[index][2],
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
