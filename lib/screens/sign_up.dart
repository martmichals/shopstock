import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: <Widget>[
          Center(
              child: Text("Sign Up")),
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