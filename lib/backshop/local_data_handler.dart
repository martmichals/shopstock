import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shopstock/backshop/server_response_parsing.dart';

import 'package:shopstock/backshop/item.dart';
import 'package:shopstock/backshop/session_details.dart';

// Filenames
const ItemsCategoriesFilename = 'items_categories.json';
const KeyFilename = 'shopstock_key.txt';

/*  Method to save the list of items
    Returns true if the write was a success, false otherwise
 */
Future<bool> saveItemsCategories(String itemsCategoriesJson) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$ItemsCategoriesFilename');
    await file.writeAsString(itemsCategoriesJson);
    return true;
  } on Exception {
    print('Saving of $ItemsCategoriesFilename was a failure');
    return false;
  }
}

/*  Method to save the API key for the server to a local file
    Returns true on success
 */
Future<bool> saveKey() async{
  try{
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$KeyFilename');
    await file.writeAsString(Session.shopstockAPIKey);
    return true;
  } on Exception {
    print('Failed to write $KeyFilename to disk');
    return false;
  }
}

/*  Method to read the list of items from the disk
    Returns the string from the file if successful, null otherwise
 */
Future<List<Item>> readItems() async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$ItemsCategoriesFilename');
    String json = await file.readAsString();
    Session.allItems = parseAllItems(json);
    return Session.allItems;
  }on FileSystemException catch(err){
    print('File system issue.\n${err.toString()}');
    return null;
  }on Exception {
    print('Failed to read $ItemsCategoriesFilename from disk');
    return null;
  }
}

/*  Method to read from disk and initialize Session.assigner
    Returns true on success
 */
Future<bool> initializeSessionAssigner() async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$ItemsCategoriesFilename');
    String json = await file.readAsString();

    Session.assigner = createAssigner(json);
    return true;
  }on FileSystemException catch(err){
    print('File system issue.\n${err.toString()}');
    return false;
  }on Exception {
    print('Failed to read $ItemsCategoriesFilename from disk');
    return false;
  }
}

/*  Method to read from disk to initialize the API key
    Returns true on success
 */
Future<bool> initializeSessionKey() async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$KeyFilename');

    final key = await file.readAsString();
    if(key.length == 0)
      return false;

    Session.shopstockAPIKey = key;
    return true;
  }on FileSystemException catch(err){
    print('File system issue.\n${err.toString()}');
    return false;
  }on Exception {
    print('Failed to read $KeyFilename from disk');
    return false;
  }
}



