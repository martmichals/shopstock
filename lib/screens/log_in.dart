import 'package:flutter/material.dart';
import '../theme.dart';

const FONT_SIZE = 20.0;
class LogIn extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LogIn> {

  bool _rememberMe = false; //state of remember me checkbox

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
                  'Sign In',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTextField("Email", false),
                _buildTextField("Password", true),
                SizedBox(height: 20.0),
                _buildRememberMe(),
                _buildLogInButton(),
                _buildSignUpButton(),
              ],
            ),
          ),
        ),
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

  Widget _buildRememberMe() {
    return Container(
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: AppColors.primary),
            child: Checkbox(
              value: _rememberMe,
              checkColor: AppColors.accentDark,
              activeColor: AppColors.accent,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogInButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.pushReplacementNamed(context, "/map_explore"),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Theme.of(context).buttonColor,
        child: Text(
          'LOGIN',
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/log_in/sign_up"),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14.0,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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