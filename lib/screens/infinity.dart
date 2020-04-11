import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shopstock/main.dart';
import '../theme.dart';

class Infinity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfinityState();
}

class _InfinityState extends State<Infinity> {
  final questions = <String>[
    "Are eggs in stock?",
    "Is bread in stock?",
    "Is milk in stock?"
  ];

  int question = 0;

  void _exit() {
    Navigator.pushNamedAndRemoveUntil(context, '/map_explore', (Route<dynamic> route) => false);
  }

  void _nextQuestion()  {
    if (question == questions.length - 1) {
      _exit();
    }
    else {
      setState(() {
        question = min(question + 1, questions.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Text(
            questions[question],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Row(
            children: <Widget>[
              AppButton(
                text: "Yes",
                onPressed: _nextQuestion
              ),
              AppButton(
                text: "No",
                onPressed: _nextQuestion
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Center(
            child: AppButton(
              text: "Exit",
              onPressed: _exit
            ),
          )
        ],
      ),
    );
  }
}