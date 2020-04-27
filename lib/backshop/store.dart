import 'package:shopstock/backshop/coordinate.dart';

import 'package:shopstock/backshop/item.dart';
import 'api_caller.dart';

// Class to represent a Store
class Store{
  final int _storeID;
  final String _storeName;
  final String _storeAddress;
  final Coordinate _location;

  List<Item> _items = <Item>[];

  // Constructor
  Store(this._storeID, this._storeName, this._storeAddress, this._location);

  // Factory for JSON instantiation
  factory Store.fromJson(dynamic json){
    return Store(json['id'] as int, json['name'] as String,
                 json['address'] as String,
                 Coordinate(json['lat'] as double, json['long'] as double));
  }

  // Async Getter Methods
  // TODO: Change this to simply fill _items
  Future<List<Item>> fillItems() async => await getItemsInStore(_storeID);

  // Getter Methods
  int get storeID => _storeID;
  String get storeName => _storeName;
  String get storeAddress => _storeAddress;
  Coordinate get location => _location;
  List<Item> get items => _items;

  @override
  String toString() => 'Store Name: $_storeName || Location:$_storeAddress || '
      'Coordinates: $_location\n';
}
