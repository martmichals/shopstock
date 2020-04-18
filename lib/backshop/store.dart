import 'package:shopstock/backshop/coordinate.dart';

import '../Item.dart';
import 'api_caller.dart';

// Class to represent a Store
class Store{
  final String _storeID;
  final String _storeName;
  final String _storeAddress;
  final Coordinate _location;

  // Constructor
  Store(this._storeID, this._storeName, this._storeAddress, this._location);

  // Async Getter Methods
  Future<List<Item>> getItems() async => await getItemsInStore(_storeID);

  // Getter Methods
  String get storeID => _storeID;
  String get storeName => _storeName;
  String get storeAddress => _storeAddress;
  Coordinate get location => _location;

  @override
  String toString() => 'Store Name: $_storeName\nLocation:$_storeAddress';
}