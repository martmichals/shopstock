import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shopstock/backshop/server_response_parsing.dart';

import '../Item.dart';

const ItemsFilename = 'items.json';
const ItemCategoriesFilename = 'item_categories.json';

// TODO : Test the methods below
/*  Method to save the list of items
    Returns true if the write was a success, false otherwise
 */
Future<bool> saveItems(String itemsJson) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$ItemsFilename');
    await file.writeAsString(itemsJson);
    return true;
  } on Exception {
    print('Saving of $ItemsFilename was a failure');
    return false;
  }
}

/*  Method to read the list of items from the disk
    Returns the string from the file if successful, null otherwise
 */
Future<List<Item>> readItems() async{
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$ItemsFilename');
    String json = await file.readAsString();
    return parseAllItems(json);
  }on FileSystemException catch(err){
    print('File system issue.\n${err.toString()}');
    return null;
  }on Exception {
    print('Failed to read $ItemsFilename from disk');
    return null;
  }
}
