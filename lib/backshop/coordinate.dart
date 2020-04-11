// Class to represent a gps coordinate
class Coordinate {
  final double _lat;
  final double _long;

  // Constructor
  Coordinate(this._lat, this._long);

  // Getter methods
  double get lat => _lat;
  double get long => _long;

  @override
  String toString() => '($_lat, $_long)';
}
