import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (dateTime) {

                      },
                      backgroundColor: Colors.white,
                      mode: CupertinoDatePickerMode.dateAndTime,
                      minimumDate: DateTime.now().add(new Duration(days: -7)),
                      initialDateTime: DateTime.now(),
                      maximumDate: DateTime.now(),
                    ),
                  height: 300,
                ),
              ],
            ),
          ),
          Center(
              child: AppButton(
                text: "Report",
                onPressed: () {
                  Navigator.pushNamed(context, "/map_explore/store_info/report/infinity");
                },
              )
          )
        ],
      ),
    );
  }
}