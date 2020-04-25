import 'package:shopstock/backshop/coordinate.dart';

import 'package:shopstock/backshop/item.dart';
import 'api_caller.dart';

// Class to represent a Store
class Store{
  final int _storeID;
  final String _storeName;
  final String _storeAddress;
  final Coordinate _location;

  // Constructor
  Store(this._storeID, this._storeName, this._storeAddress, this._location);

  // Factory for JSON instantiation
  factory Store.fromJson(dynamic json){
    return Store(json['id'] as int, json['name'] as String,
                 json['address'] as String,
                 Coordinate(json['lat'] as double, json['long'] as double));
  }

  // Async Getter Methods
  Future<List<Item>> getItems() async => await getItemsInStore(_storeID);

  // Getter Methods
  int get storeID => _storeID;
  String get storeName => _storeName;
  String get storeAddress => _storeAddress;
  Coordinate get location => _location;

  @override
  String toString() => 'Store Name: $_storeName || Location:$_storeAddress || '
      'Coordinates: $_location\n';
}