import 'dart:convert';

import 'package:shopstock/backshop/category_assigner.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/backshop/item.dart';

// Method to parse the response from getStoresInArea
List<Store> parseStoresInArea(String storesJSON) {
  var storeObjJson = jsonDecode(storesJSON)['stores'] as List;
  return storeObjJson.map((storeJson) => Store.fromJson(storeJson)).toList();
}

// Method to parse the list of all items
List<Item> parseAllItems(String itemsCategoriesJson) {
  var items = jsonDecode(itemsCategoriesJson)['items'] as List;
  return items.map((item) => Item.fromJson(item)).toList();
}

// Method to initialize an assigner
CategoryAssigner createAssigner(String itemsCategoriesJson) {
  var categories = jsonDecode(itemsCategoriesJson)['item_categories'] as List;
  var assigner = CategoryAssigner.blank();
  categories.forEach((category) =>
      assigner.addCategory(category['id'] as int, category['name'] as String));
  return assigner;
}

// Method to paste the detailed return for a particular store
Store parseStore(String storeJSON) {
  return null;
}
