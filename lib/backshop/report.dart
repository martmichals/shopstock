import 'package:shopstock/backshop/item.dart';
import 'package:shopstock/backshop/session_details.dart';
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

  // Method to convert the object to a json string
  String toJson(){
    List<int> inStockIds = [];
    List<int> outOfStockIds = [];

    // TODO: Make sure that the proper items are being labelled
    _labellings.forEach((key, value) => value == 1 ? inStockIds.add(key) : outOfStockIds.add(key));

    // Iterate over the lists of item ids
    String str = '{\"in_stock_items\": [';
    for(var i = 0; i < inStockIds.length; i++){
      str += '${inStockIds[i]}';
      if(i != inStockIds.length - 1)
       str += ', ';
    }
    str += '], \"no_stock_items\": [';
    for(var i = 0; i < outOfStockIds.length; i++){
      str += '${outOfStockIds[i]}';
      if(i != outOfStockIds.length - 1)
        str += ', ';
    }
    str += '], \"store_id\": ${store.storeID}, \"timestamp\": ';

    int secondsSinceEpoch;
    if(_time != null)
      secondsSinceEpoch = (_time.millisecondsSinceEpoch / 1000).round();
    else
      return null;

    str += '$secondsSinceEpoch, \"key\": \"${Session.shopstockAPIKey}\"}';
    print(str);
    return str;
  }
}