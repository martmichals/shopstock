import 'package:shopstock/backshop/coordinate.dart';

import 'package:shopstock/backshop/item.dart';
import 'api_caller.dart';

// Class to represent a Store
class Store{
  final int _id;
  final String _name;
  final String _address;
  final Coordinate _location;

  List<Item> _items = <Item>[];

  // Constructor
  Store(this._id, this._name, this._address, this._location);

  // Factory for JSON instantiation
  factory Store.fromJson(dynamic json){
    return Store(json['id'] as int, json['name'] as String,
                 json['address'] as String,
                 Coordinate(json['lat'] as double, json['long'] as double));
  }

  // Getter Methods
  int get id => _id;
  String get name => _name;
  String get address => _address;
  Coordinate get location => _location;
  List<Item> get items => _items;

  @override
  String toString() => 'Store Name: $_name || Location:$_address || '
      'Coordinates: $_location\n';
}
