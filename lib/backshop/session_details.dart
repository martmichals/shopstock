import 'package:shopstock/backshop/category_assigner.dart';
import 'package:shopstock/backshop/report.dart';
import 'map_handler.dart';

// Session details, need to be accessible from anywhere
class Session{
  // Static variables for auth and security
  static var shopstockAPIKey;
  static var isLongTermKey; // TODO: Initialize this in the log in process

  // Static variables required for each session
  static MapHandler mapHandler;
  static CategoryAssigner assigner;

  // Static variables sometimes used in a session
  static Report userReport;
}