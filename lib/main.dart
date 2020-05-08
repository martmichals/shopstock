import 'package:flutter/material.dart';
import 'package:shopstock/backshop/api_caller.dart';
import 'backshop/map_handler.dart';
import 'backshop/session_details.dart';
import 'screens/screens.dart';
import 'theme.dart';
import 'strings.dart';

void main() => runApp(App());

class App extends StatelessWidget  {
  @override
  Widget build(BuildContext context){

    // Initialization of required app variables
    Session.mapHandler = MapHandler.blank();
    getItemsCategories();

    // End test code for async

    return MaterialApp(
      title: Strings.title,
      initialRoute: "/log_in",
      theme: AppTheme,
      routes: {
        "/log_in": (context) => LogIn(),
        "/log_in/sign_up" : (context) => SignUp(),
        "/log_in/sign_up/tutorial" : (context) => Tutorial(),
        "/map_explore": (context) => MapExplore(),
        "/map_explore/store_info" : (context) => StoreInfo(),
        "/map_explore/store_info/report" : (context) => Report(),
      },
    );
  }
}
