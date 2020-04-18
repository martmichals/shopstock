import 'package:shopstock/backshop/api_caller.dart';
import 'package:shopstock/backshop/coordinate.dart';
import 'package:shopstock/backshop/store.dart';

//Class to represent the state of the screen, manage data pulled from the API
class MapHandler {
  static const ExpansionFactor = 0.2;

  Coordinate _southWestScreen;
  Coordinate _northEastScreen;
  Coordinate _southWestData;
  Coordinate _northEastData;
  List<Store> _storesInArea;
  List<Store> _screenStoresLast;

  // Constructor for a blank MapHandler
  MapHandler.blank() {
    _southWestScreen = null;
    _northEastScreen = null;
    _southWestData = null;
    _northEastData = null;
    _storesInArea = null;
    _screenStoresLast = null;
  }

  // Method to get the stores in the screen area, either from API or data in memory
  Future<List<Store>> getStoresInScreen(Coordinate sw, Coordinate ne) async {
    this._southWestScreen = sw;
    this._northEastScreen = ne;

    if (_southWestData == null || _northEastData == null) {
      await updateArea();
    } else if (_southWestScreen.lat < _southWestData.lat ||
        _southWestScreen.long < _southWestScreen.long ||
        _northEastScreen.lat > _northEastData.lat ||
        _northEastData.long > _northEastData.long) {
      await updateArea();
    } else {
      return _screenStoresLast;
    }

    // Sort through stores in _storesInArea and return the ones on screen
    var screenStores = [];
    for (final store in _storesInArea) {
      if (store.location.lat > _southWestScreen.lat &&
          store.location.long > _southWestScreen.long &&
          store.location.lat < _northEastScreen.lat &&
          store.location.long < _northEastScreen.long) screenStores.add(store);
    }
    _screenStoresLast = screenStores;
    return _screenStoresLast;
  }

  // Updates the area of the data, and pulls required data for the update
  Future<void> updateArea() async {
    final expansionLat =
        (_northEastScreen.lat - _southWestScreen.lat) * ExpansionFactor;
    final expansionLong =
        (_northEastScreen.long - _northEastScreen.long) * ExpansionFactor;

    _southWestData.setLat(_southWestScreen.lat - expansionLong);
    _southWestData.setLong(_southWestScreen.long - expansionLong);
    _northEastData.setLat(_northEastScreen.lat + expansionLat);
    _northEastData.setLong(_northEastScreen.long + expansionLong);

    var pulledList = await getStoresInArea(_southWestData, _northEastData);
    if (pulledList == null) _storesInArea = new List(0);
  }

  @override
  String toString() {
    return 'Southwest Screen Corner: $_southWestScreen\n'
        'Northeast Screen Corner: $_northEastScreen\n'
        'Southwest Data Corner:$_southWestData\n'
        'Northeast Data Corner:$_northEastData\n';
  }
}
