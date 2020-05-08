// Base url for all API calls
import 'dart:convert';
import 'dart:io';

import 'package:shopstock/backshop/coordinate.dart';
import 'package:shopstock/backshop/server_response_parsing.dart';
import 'package:shopstock/backshop/session_details.dart';
import 'package:shopstock/backshop/store.dart';
import 'package:shopstock/backshop/item.dart';
import 'server_response_parsing.dart';
import 'package:http/http.dart' as http;

const String ShopstockUrl = 'https://shopstock.live/api/';
const String TAG = 'apicaller - ';

// Method to get the stores in a rectangular area
Future<List<Store>> getStoresInArea(
    Coordinate southWest, Coordinate northEast) async {
  final requestUrl = '${ShopstockUrl}get_stores_in_area?lat_1=${southWest.lat}'
      '&lat_2=${northEast.lat}&long_1=${southWest.long}'
      '&long_2=${northEast.long}';
  print(requestUrl);

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
// TODO : Make sure to call the full constructor
// Method to get the items in a store
Future<List<Item>> getItemsInStore(int storeID) {
  return null;
}

/*  Method to get and save the list of all items
    Returns true if the pull and save were successful
 */
Future<bool> getItemsCategories() async {
  final requestUrl = '${ShopstockUrl}get_items';
  try {
    final request = await HttpClient().getUrl(Uri.parse(requestUrl));
    final response = await request.close();

    // Parse the response input stream
    var responseString = '';
    await for (var contents in response.transform(Utf8Decoder())) {
      responseString += '$contents';
    }
    // Initialize Session.assigner as well as the list of all items
    Session.assigner = createAssigner(responseString);
    Session.allItems = parseAllItems(responseString);

    return true;
  } on SocketException {
    print('$TAG: No connection');
  } on Exception {
    print('$TAG: App error in getItemsCatergories');
  }
  return false;
}

/*  Method to send report, returns null on success
    String with an error message otherwise
 */
Future<String> sendReport() async {
  final reportJson = Session.userReport.toJson();
  if (reportJson == null) return 'You did not fill the time field!';

  final url = ShopstockUrl + 'send_report';
  Map<String, String> headers = {'Content-type': 'application/json'};

  int statusCode;
  try {
    http.Response response =
        await http.post(url, headers: headers, body: reportJson);
    statusCode = response.statusCode;
  } on SocketException {
    return 'Looks like you are not connected to the internet!';
  } on Exception {
    return 'Something went wrong when sending the report';
  }

  if (statusCode != 200) return 'Something went wrong when sending the report';

  return null;
}

/*  Method to log in, returns null if the log in was a success
    String with an error message otherwise
 */
Future<String> logIn(final email, final password, final stayLoggedIn) async {
  Session.isLongTermKey = stayLoggedIn;

  // TODO: Launch log in request

  return null;
}

/*  Method to sign up, returns null if the sign up was a success
    String with an error message otherwise
 */
Future<String> signUp(final nickname, final email, final password) async {
  // Assembling the body
  final body = '{\"name\": \"$nickname\", \"email\": \"$email\", \"password\": '
      '\"$password\"}';
  final url = ShopstockUrl + 'create_account';
  Map<String, String> headers = {'Content-type': 'application/json'};
  print(body);

  int statusCode;
  http.Response response;
  try {
    response = await http.post(url, headers: headers, body: body);
    statusCode = response.statusCode;
  } on SocketException {
    return 'Looks like you are not connected to the internet';
  } on Exception {
    return 'Something went wrong while signing up';
  }

  // Error message generation for the user
  if (statusCode != 200){
    final parsedError = parseError(response.body);
    if(parsedError != null){
      return parsedError;
    }
    return 'Something went wrong in the account creation process, try once more';
  }
  return null;
}
