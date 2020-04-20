// Class to represent a gps coordinate
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinate {
  double _lat;
  double _long;

  // Constructor
  Coordinate(this._lat, this._long);

  // Factory to generate coordinate from LatLngObject
  factory Coordinate.fromLatLng(LatLng coordinate) =>
      Coordinate(coordinate.latitude, coordinate.longitude);

  // Getter methods
  double get lat => _lat;
  double get long => _long;

  // Setter methods
  void setLat(double lat) => this._lat = lat;
  void setLong(double long) => this._long = long;

  @override
  String toString() => '($_lat, $_long)';
}
