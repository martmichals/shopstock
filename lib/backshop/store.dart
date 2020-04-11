import 'package:shopstock/backshop/coordinate.dart';

// Class to represent a Store
class Store{
  final String _storeID;
  final String _storeName;
  final String _storeAddress;
  final Coordinate _location;

  // TODO : Add a SplayTreeMap for <K:V> pairs (itemID:confidence)

  // Constructor
  Store(this._storeID, this._storeName, this._storeAddress, this._location);

  // Getter Methods
  String get storeID => _storeID;
  String get storeName => _storeName;
  String get storeAddress => _storeAddress;
  Coordinate get location => _location;

  @override
  String toString() => 'Store Name: $_storeName\nLocation:$_storeAddress';
}