// Base url for all API calls
import 'dart:convert';
import 'dart:io';

import 'package:shopstock/backshop/coordinate.dart';
import 'package:shopstock/backshop/report.dart';
import 'package:shopstock/backshop/server_response_parsing.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/backshop/local_data_handler.dart';

import '../Item.dart';

const String ShopstockUrl = 'https://shopstock.live/api/';
const String TAG = 'apicaller - ';

// Method to get the stores in a rectangular area
Future<List<Store>> getStoresInArea(Coordinate southWest, Coordinate northEast) async {
  final requestUrl = '${ShopstockUrl}get_stores_in_area?lat_1=${southWest.lat}'
      '&lat_2=${northEast.lat}&long_1=${southWest.long}'
      '&long_2=${northEast.long}';

  try {
    final request = await HttpClient().getUrl(Uri.parse(requestUrl));
    final response = await request.close();

    // Parse the response input stream
    var responseString = '';
    await for (var contents in response.transform(Utf8Decoder())) {
      responseString += '$contents';
    }
    return parseStoresInArea(responseString);
  } on SocketException {
    print('$TAG: No connection');
    return null;
  } on Exception {
    print('$TAG: App error in getStoresInArea');
    return null;
  }
}

// TODO : Implement the API call to get the items in the store
// Method to get the items in a store
Future<List<Item>> getItemsInStore(int storeID){
  return null;
}

/*  Method to get and save the list of all items
    Returns true if the pull and save were successful
 */
Future<bool> getAndSaveItems() async{
  final requestUrl = '${ShopstockUrl}get_items';
  try{
    final request = await HttpClient().getUrl(Uri.parse(requestUrl));
    final response = await request.close();

    // Parse the response input stream
    var responseString = '';
    await for (var contents in response.transform(Utf8Decoder())) {
      responseString += '$contents';
    }
    return await saveItems(responseString);
  } on SocketException{
    print('$TAG: No connection');
  } on Exception{
    print('$TAG: App error in getAndSaveItems');
  }
  return false;
}

// TODO: Implement a method to send report data
Future<bool>sendReport(Report report){
  return null;
}
