// Class to represent an Item
class Item {
  final int _itemID;
  final String _name;
  final int _categoryID;
  double _labelling;

  // Constructor
  Item(this._itemID, this._name, this._categoryID, this._labelling);

  // Getter methods
  int get itemID => _itemID;
  String get name => _name;
  int get categoryName => _categoryID;
  double get confidence => _labelling;

  // Setter methods
  void set(double labelling) => this._labelling = labelling;

  @override
  String toString() => 'Item $_itemID\nName:$_name';
}
