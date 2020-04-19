import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopstock/backshop/store.dart';

import '../Item.dart';

// Method to parse the response from getStoresInArea
List<Store> parseStoresInArea(String storesJSON) {
  print(storesJSON);

  var storeObjJson = jsonDecode(storesJSON)['stores'] as List;
  List<Store> stores =
      storeObjJson.map((storeJson) => Store.fromJson(storeJson)).toList();

  print(stores);
  return null;
}

// Method to parse the list of all items
List<Item> parseAllItems(String itemJSON) {
  return null;
}

// Method to paste the detailed return for a particular store
Store parseStore(String storeJSON) {
  return null;
}
