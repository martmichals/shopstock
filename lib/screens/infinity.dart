import 'package:flutter/material.dart';

class Infinity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
              child: Text("Infinity")),
          BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}