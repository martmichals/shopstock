import 'package:shopstock/item_report.dart';

class ItemReportList {
  static final itemNames = {
    "Bread",
    "Milk",
    "Cheese",
    "Yogurt",
    "Ceral",
    "Bagels"
  };
  var itemList;

  ItemReportList() {
    itemList = itemNames.map((x) {
      return ItemReport(x, 0);
    }).toList();
  }

  void setReport(String name, bool stock) {
    for (var item in itemList) {
      if (item.name == name) {
        item.status = (stock ? 1 : -1);
        return;
      }
    }
  }

  void removeReport(String name) {
    for (var item in itemList) {
      if (item.name == name) {
        item.status = 0;
        return;
      }
    }
  }

  ItemReport getReport(int index) {
    return itemList[index];
  }

  List<ItemReport> getList() {
    return itemList;
  }

  int getSize() {
    return itemNames.length;
  }
}