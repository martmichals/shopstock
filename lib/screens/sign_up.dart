import 'package:flutter/material.dart';
import '../theme.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>(); //for validation/saving
  bool _autoValidate = false; //form will begin auto validating after unsuccessful submit

  //controllers to retrieve text field values
  final TextEditingController _nicknameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _confirmPasswordControl = TextEditingController();

  //save values--set after button onPressed
  String _nickName, _email, _password;

  //default textField style
  //here as to not mess with theme.dart
  final fieldStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 16.0,
  );

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
              _buildTextFields(),
              _buildSignUpButton(),
              _buildLogInButton(),

            ],
          )
        )
      )
    );
  }

  Widget _buildTextFields() {
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            _buildNickname(),
            _buildEmail(),
            _buildPassword(),
            _buildConfirmPassword()
          ],
        )
    );
  }

  Widget _buildNickname() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Nickname",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentDark)
            )
        ),
        style: fieldStyle,
        controller: _nicknameControl,
        //rejects empty field
        validator: (value) {
          if (value.isEmpty) {
            return "Field cannot be empty";
          }
          return null;
        },
        onSaved: (value) {
          _nickName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            labelText: "Email",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentDark)
            )
        ),
        style: fieldStyle,
        controller: _emailControl,
        //rejects empty field, email pattern validation
        validator: (value) {
          Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (value.isEmpty)
            return "Field cannot be empty";
          else if(!regex.hasMatch(value))
            return "Invalid Email";
          return null;
        },
        onSaved: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Password",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentDark)
            )
        ),
        style: fieldStyle,
        obscureText: true,
        controller: _passwordControl,
        validator: (value) {
          //Pattern pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})';
          //return information separated for clarity to user
          if (value.isEmpty)
            return "Field cannot be empty";
          //at least 8 characters: 1 lowercase, 1 uppercase, 1 number, 1 special character
          else if(!RegExp('(?=.*[a-z])').hasMatch(value))
            return "Password must contain a lowercase letter";
          else if(!RegExp('(?=.*[A-Z])').hasMatch(value))
            return "Password must contain a capital letter";
          else if(!RegExp('(?=.*[0-9])').hasMatch(value))
            return "Password must contain a number";
          else if(!RegExp('(?=.*[!@#\$%^&*])').hasMatch(value))
            return "Password must contain a special character (!@#\$%^&*)";
          else if(value.length < 8)
            return "Password must be at least 8 characters";
          return null;
        },
        onSaved: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Confirm Password",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentDark)
            )
        ),
        style: fieldStyle,
        obscureText: true,
        controller: _confirmPasswordControl,
        //field must not be empty, and must match password field
        validator: (value) {
          if (value.isEmpty) {
            return "Field cannot be empty";
          } else if(value != _passwordControl.text) {
            return "Passwords must match";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        //validation control
        onPressed: () {
          if(_formKey.currentState.validate()) {
            _formKey.currentState.save();
            //all fields have been preliminarily validated
            //**ACCOUNT CREATION GOES HERE
            Navigator.pushNamed(context, "/log_in");
          } else { //being auto validation
            setState(() {
              _autoValidate = true;
            });
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Theme.of(context).buttonColor,
        child: Text(
          'SIGN UP',
          style: Theme.of(context).textTheme.button,
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