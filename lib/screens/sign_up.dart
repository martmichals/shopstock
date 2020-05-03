import 'package:flutter/material.dart';
import '../theme.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUp> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 120.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildTextField("First Name", false),
              _buildTextField("Last Name", false),
              _buildTextField("Email", false),
              _buildTextField("Password", true),
              _buildTextField("Confirm Password", true),
              _buildSignUpButton(),
              _buildLogInButton(),
            ],
          )
        )
      )
    );
  }

  Widget _buildTextField(String text, bool passwordField) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            labelText: text,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentDark)
            )
        ),
        obscureText: passwordField,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pushNamed(context, "/log_in"),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Theme.of(context).buttonColor,
        child: Text(
          'SIGN UP',
        ),
      ),
    );
  }

  Widget _buildLogInButton() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/log_in"),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14.0,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}