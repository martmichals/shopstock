import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shopstock/backshop/session_details.dart';

// Filenames
const KeyFilename = 'shopstock_key.txt';

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

/*  Method to read from disk to initialize the API key
    Checks with the server to see if the key is valid as well
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



