// Base url for all API calls
import 'dart:convert';
import 'dart:io';

import 'package:shopstock/backshop/coordinate.dart';
import 'package:shopstock/backshop/server_response_parsing.dart';
import 'package:shopstock/backshop/store.dart';

const String ShopstockUrl = 'https://shopstock.live/api/';
const String TAG = 'apicaller - ';

// Method to get the stores in a rectangular area
Future<List<Store>> getStoresInArea(Coordinate southWest, Coordinate northEast) async {
  String requestUrl = '${ShopstockUrl}get_stores_in_area?lat_1=${southWest.lat}'
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
