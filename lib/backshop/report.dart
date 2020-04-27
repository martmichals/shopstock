import 'package:shopstock/backshop/item.dart';
import 'package:shopstock/backshop/store.dart';


// Class that interacts with the UI to create a report
class Report{
  final Store _store;
  Map<int, int> _labellings;
  DateTime _time;

  // Constructor
  Report(this._store){
    _labellings = Map();
  }

  // Manipulating the labels
  void addNewLabel(Item item, int label) => _labellings.putIfAbsent(item.itemID, () => label);
  void removeLabel(Item item) => _labellings.remove(item.itemID);

  // Setter methods
  void setTime(DateTime time) => _time = time;

  // Getter methods
  Store get store => _store;
  Map<int, int> get labellings => _labellings;
  DateTime get time => _time;
}