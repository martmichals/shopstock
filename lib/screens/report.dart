import 'package:flutter/material.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: <Widget>[
          Center(
              child: Text("Report")),
          MaterialButton(
            child: Text("Infinity"),
            onPressed: () {
              Navigator.pushNamed(context, "/map_explore/store_info/report/infinity");
            },
          ),
          BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

}