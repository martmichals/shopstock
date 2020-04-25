// Class to represent an Item
class Item {
  final int _itemID;
  final String _name;
  final int _categoryID;
  double _labelling;

  // Constructor
  Item(this._itemID, this._name, this._categoryID);

  // Factory to create item from JSON
  factory Item.fromJson(dynamic json){
    return Item(json['id'] as int, json['name'] as String, json['item-category'] as int);
  }

  // Getter methods
  int get itemID => _itemID;
  String get name => _name;
  int get categoryName => _categoryID;
  double get labelling => _labelling;

  // Setter methods
  void setLabelling(double labelling) => this._labelling = labelling;

  @override
  String toString() => 'Item $_itemID\nName:$_name';
}
