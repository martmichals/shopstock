import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/coordinate.dart';
import 'package:shopstock/backshop/store.dart';

import 'coordinate.dart';

//Class to represent the state of the screen, manage data pulled from the API
class MapHandler {
  static const ExpansionFactor = 0.2;

  Coordinate _southWestScreen;
  Coordinate _northEastScreen;
  Coordinate _southWestData;
  Coordinate _northEastData;
  List<Store> _storesInArea;

  // Constructor for a blank MapHandler
  MapHandler.blank() {
    _southWestScreen = null;
    _northEastScreen = null;
    _southWestData = null;
    _northEastData = null;
    _storesInArea = null;
  }

  // Method to get the stores in the screen area, either from API or data in memory
  Future<List<Store>> getStoresInScreen(Coordinate sw, Coordinate ne) async {
    this._southWestScreen = sw;
    this._northEastScreen = ne;

    if (_storesInArea == null) {
      await _updateArea();
    } else if (_southWestScreen.lat < _southWestData.lat ||
        _southWestScreen.long < _southWestScreen.long ||
        _northEastScreen.lat > _northEastData.lat ||
        _northEastData.long > _northEastData.long) {
      await _updateArea();
    } else {
    }

    return _getStoresFromMemory();
  }

  // Updates the area of the data, and pulls required data for the update
  Future<void> _updateArea() async {
    final expansionLat =
        (_northEastScreen.lat - _southWestScreen.lat) * ExpansionFactor;
    final expansionLong =
        (_northEastScreen.long - _southWestScreen.long) * ExpansionFactor;

    _southWestData = Coordinate(_southWestScreen.lat - expansionLat,
        _southWestScreen.long - expansionLong);
    _northEastData = Coordinate(_northEastScreen.lat + expansionLat,
        _northEastScreen.long + expansionLong);

    final pulledList = await getStoresInArea(_southWestData, _northEastData);
    if (pulledList == null) {
      _storesInArea = new List(0);
    }else{
      _storesInArea = pulledList;
    }
  }

  // Sort through stores in _storesInArea and return the ones on screen
  List<Store> _getStoresFromMemory() {
    var screenStores = <Store>[];
    for (final store in _storesInArea) {
      if (store.location.lat > _southWestScreen.lat &&
          store.location.long > _southWestScreen.long &&
          store.location.lat < _northEastScreen.lat &&
          store.location.long < _northEastScreen.long) screenStores.add(store);
    }
    return screenStores;
  }

  @override
  String toString() {
    return 'Southwest Screen Corner: $_southWestScreen\n'
        'Northeast Screen Corner: $_northEastScreen\n'
        'Southwest Data Corner:$_southWestData\n'
        'Northeast Data Corner:$_northEastData\n'
        '_storesInArea: $_storesInArea\n';
  }
}
