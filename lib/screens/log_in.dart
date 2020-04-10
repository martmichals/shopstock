import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
            Center(
                child: Text("Log In")),
            MaterialButton(
              child: Text("Sign Up"),
              onPressed: () {
                Navigator.pushNamed(context, "/log_in/sign_up");
              },
            ),
            MaterialButton(
              child: Text("Map Explore"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/map_explore");
              },
            )
          ],
        )
    );
  }
}