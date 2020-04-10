import 'package:flutter/material.dart';

class StoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
              child: Text("Store Info")),
          MaterialButton(
            child: Text("Report"),
            onPressed: () {
              Navigator.pushNamed(context, "/map_explore/store_info/report");
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