import 'package:flutter/material.dart';
import '../theme.dart';

class Tutorial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  static const IMAGE_COUNT = 4;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration(),
        child:  ListView(
          children: <Widget>[
            Expanded(
              child: FittedBox(
                child: Padding(
                  child: Image.asset('lib/tutorial_images/image' + index.toString() + ".jpg"),
                  padding: EdgeInsets.fromLTRB(PADDING, PADDING, PADDING, 0),
                ),
                fit: BoxFit.fill,
              ),
            ),
            Center(
                child: AppButton(
                  text: "Continue",
                  onPressed: () {
                    if (index + 1 >= IMAGE_COUNT) {
                      Navigator.pushReplacementNamed(context, "/log_in");
                    }
                    else {
                      setState(() {
                        index++;
                      });
                    }
                  },
                )
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}