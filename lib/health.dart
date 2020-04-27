import 'package:shopstock/backshop/local_data_handler.dart';
import 'package:shopstock/backshop/session_details.dart';

/*  Methods in this file check the "health" of the app, giving information
    on the log in status of the user, as well as API key status
 */

// Check that essentials for pulling store data are present
bool checkEssentialsMap() => !(Session.shopstockAPIKey == null);

// Check that variables for recording a trip are present
bool checkEssentialsRecording() =>
    !(Session.assigner == null || Session.shopstockAPIKey == null);

// Handling the API key on application startup
Future<bool> setupKey() async {
  if (Session.isLongTermKey) {
    final isSavedKey = await initializeSessionKey();
    if (!isSavedKey) {
      // TODO: Pull the key from the server
      return true;
    }
  }else{
    // Just check for the key
    if(Session.shopstockAPIKey != null) {
      if (Session.shopstockAPIKey.length != 0) {
        return true;
      }
    }
    return false;
  }
}
