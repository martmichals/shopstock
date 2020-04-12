import 'package:flutter/material.dart';
import '../theme.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          AppTextField(
            hintText: "Username",
          ),
          AppTextField(
            hintText: "Password",
          ),
          Center(
              child: AppButton(
                text: "Log in",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/map_explore");
                },
              )
          ),
          Center(
              child: AppButton(
                text: "Sign Up",
                onPressed: () {
                  Navigator.pushNamed(context, "/log_in/sign_up");
                },
              )
          ),
        ],
      ),
    );
  }
}