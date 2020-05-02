import 'package:flutter/material.dart';
import '../theme.dart';
import 'dart:io';

class Tutorial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  static const IMAGE_COUNT = 4;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Expanded(
            child: FittedBox(
              child:  Image.asset('lib/tutorial_images/image' + index.toString() + ".jpg"),
              fit: BoxFit.fill,
            ),
          ),
          Center(
              child: AppButton(
                text: "Continue",
                onPressed: () {
                  if (index + 1 >= IMAGE_COUNT) {
                    Navigator.pushReplacementNamed(context, "/log_in");
                  }
                  setState(() {
                    index++;
                  });
                },
              )
          ),
        ],
      ),
    );
  }
}