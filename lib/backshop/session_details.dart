import 'package:shopstock/backshop/category_assigner.dart';
import 'map_handler.dart';

// Session details, need to be accessible from anywhere
class Session{
  static var shopstockAPIKey;
  static MapHandler mapHandler;
  static CategoryAssigner assigner;
  static bool isConnectionIssue;
}