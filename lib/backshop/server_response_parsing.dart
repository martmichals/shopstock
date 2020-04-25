import 'dart:convert';

import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/backshop/item.dart';



// Method to parse the response from getStoresInArea
List<Store> parseStoresInArea(String storesJSON) {
  var storeObjJson = jsonDecode(storesJSON)['stores'] as List;
  return storeObjJson.map((storeJson) => Store.fromJson(storeJson)).toList();
}

// Method to parse the list of all items
List<Item> parseAllItems(String itemsCategoriesJson) {
  print('PARSING ITEMS');
  var itemsList = List<Item>();
  var items = jsonDecode(itemsCategoriesJson)['items'] as List;
  return items.map((item) => Item.fromJson(item)).toList();

}

// Method to paste the detailed return for a particular store
Store parseStore(String storeJSON) {
  return null;
}
