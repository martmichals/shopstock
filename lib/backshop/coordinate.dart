// Class to represent a gps coordinate
class Coordinate {
  double _lat;
  double _long;

  // Constructor
  Coordinate(this._lat, this._long);

  // Getter methods
  double get lat => _lat;
  double get long => _long;

  // Setter methods
  void setLat(double lat) => this._lat = lat;
  void setLong(double long) => this._long = long;

  @override
  String toString() => '($_lat, $_long)';
}
