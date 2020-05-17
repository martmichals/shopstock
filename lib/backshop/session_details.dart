import 'dart:core';

import 'package:shopstock/backshop/category_assigner.dart';
import 'package:shopstock/backshop/report.dart';
import 'item.dart';
import 'map_handler.dart';

// Session details, need to be accessible from anywhere
class Session{
  // Static variables for auth and security
  static var shopstockAPIKey;
  static var isLongTermKey;

  // Static variables required for each session
  static MapHandler mapHandler;
  static CategoryAssigner assigner;
  static List<Item> allItems = <Item>[];

  // Static variables sometimes used in a session
  static Report userReport;

  // TODO : Async method to check the health of the key

  // Method to check the log in status of the user based on API key presence
  bool getLoginStatus(){
    if(shopstockAPIKey != null)
      return true;
    return false;
  }

  // Method to make sure all session essentials are present
  bool allEssentialsPresent(){
    if(isLongTermKey == null || mapHandler == null || assigner == null || allItems == null)
      return false;
    else if(allItems.length == 0)
      return false;

    return true;
  }
}