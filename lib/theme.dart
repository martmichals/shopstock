import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const PADDING = 16.0;
const FONT_SIZE = 24.0;

class AppColors {
  static final accent = Color(0xFFC7F9C7);
  static final accentDark = Color(0xFF3A5445);
  static final background = Color(0xFF000000);
  static final primary = Color(0xFFFFFFFF);
  static final hint = Color(0xFF666666);
  static final maybe = Color(0xFFFFFF66);
  static final yes = Color(0xFF66FF66);
  static final no = Color(0xFFFF6666);
  static final transparent = Color(0x00000000);
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

BoxDecoration backgroundDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [
          Colors.black,
          Colors.grey[900],
          Colors.grey[850],
          Colors.grey[800],
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.clamp
    ),
  );
}

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
          padding: EdgeInsets.fromLTRB(PADDING / 2, PADDING, PADDING / 2, PADDING),
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

  final Function onTextChange;

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
                        borderSide: BorderSide(color: AppColors.transparent)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.transparent)
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

class AppItemTile extends StatelessWidget {
  AppItemTile({
    @required this.title,
    @required this.onNo,
    @required this.onYes
  });

  final String title;
  final Function onNo, onYes;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check_circle,
                color: AppColors.yes,
              ),
              onPressed: onYes,
            ),
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: AppColors.no,
              ),
              onPressed: onNo,
            ),
          ],
          mainAxisSize: MainAxisSize.min
      ),
    );
  }
}

LoadingDialog({@required context, @required snapshot, @required onDone, @required onError}) {
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return onError(snapshot.error);
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              return onDone(snapshot.data);
            }
            else {
              return Center(
                  child: CircularProgressIndicator(),
              );
            }
          },
          future: snapshot,
        );
      }
  );
}

class ErrorText extends StatelessWidget {
  ErrorText({
    @required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}