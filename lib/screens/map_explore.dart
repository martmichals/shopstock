import 'package:flutter/material.dart';

class MapExplore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: <Widget>[
          Center(
              child: Text("Map Explore")),
          MaterialButton(
            child: Text("Store Info"),
            onPressed: () {
              Navigator.pushNamed(context, "/map_explore/store_info");
            },
          ),
          BackButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/log_in");
            },
          )
        ],
      ),
    );
  }
  
}