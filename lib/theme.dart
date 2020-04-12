import 'package:flutter/material.dart';
import 'package:shopstock/main.dart';

const PADDING = 16.0;
const FONT_SIZE = 24.0;

class AppColors {
  static final accent = Color(0xFFC7F9C7);
  static final accentDark = Color(0xFF3A5445);
  static final background = Color(0xFF000000);
  static final primary = Color(0xFFFFFFFF);
  static final hint = Color(0xFF666666);
}

// ignore: non_constant_identifier_names
final AppTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  buttonColor: AppColors.accent,
  hintColor: AppColors.hint,
  accentColor: AppColors.accent,
  textTheme: TextTheme(
      bodyText1: TextStyle(
          color: AppColors.primary,
          fontSize: FONT_SIZE
      ),
      bodyText2: TextStyle(
          color: Colors.grey[600],
          fontSize: FONT_SIZE
      ),
      button: TextStyle(
          color: AppColors.accentDark,
          fontSize: FONT_SIZE
      )
  ),
  fontFamily: "sans-serif",
);

class AppButton extends StatelessWidget {
  AppButton({
    @required this.onPressed,
    @required this.text
  });

  final GestureTapCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: FlatButton(
        color: Theme.of(context).buttonColor,
        child: Padding(
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.button,
          ),
          padding: EdgeInsets.all(PADDING),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000)
        ),
      ),
      padding: EdgeInsets.all(PADDING),
    );
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({
    @required this.hintText
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          contentPadding: EdgeInsets.fromLTRB(PADDING, 0, PADDING, 0),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).hintColor)
          )
      ),
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}

class AppSearchBar extends StatelessWidget {
  AppSearchBar({
    @required this.onTextChange
  });

  var onTextChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            child: Icon(
              Icons.search,
              color: AppColors.accentDark,
            ),
            padding: EdgeInsets.all(PADDING),
          ),

          Expanded(
              child: Padding(
                child: TextField(
                  style: TextStyle(
                    color: AppColors.accentDark,
                    fontSize: 24
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accentDark)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.accentDark)
                    ),
                  ),
                  onChanged: onTextChange
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
              ),
          )
        ],
      ),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          color: AppColors.accent
      ),
    );
  }
}