import 'package:flutter/material.dart';
import '../theme.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          AppTextField(
            hintText: "First Name",
          ),
          AppTextField(
            hintText: "Last Name",
          ),
          AppTextField(
            hintText: "Email",
          ),
          AppTextField(
            hintText: "Password",
          ),
          AppTextField(
            hintText: "Confirm Password",
          ),
          Center(
              child: AppButton(
                text: "Sign Up",
                onPressed: () {
                  Navigator.pop(context);
                },
              )
          ),
        ],
      ),
    );
  }
}