// Base url for all API calls
import 'dart:convert';
import 'dart:io';

import 'package:shopstock/backshop/coordinate.dart';

const String ShopstockUrl = 'https://shopstock.live/api/';

// Method to get the stores in a rectangular area
// TODO: Catch exceptions
Future<void> getStoresInArea(Coordinate southWest, Coordinate northEast) async{
  String requestUrl = '${ShopstockUrl}get_stores_in_area?lat_1=${southWest.lat}'
                      '&lat_2=${northEast.lat}&long_1=${southWest.long}'
                      '&long2=${northEast.long}';
   var request  = await HttpClient().getUrl(Uri.parse(requestUrl));
   var response = await request.close();

   // Pars the response input stream
   await for(var contents in response.transform(Utf8Decoder())){
     print(contents);
   }
}
