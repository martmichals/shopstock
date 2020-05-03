import 'backshop/item.dart';

class ItemReport {
  Item item;
  int status;

  ItemReport(Item item, int status) {
    this.item = item;
    this.status = status;
  }
}