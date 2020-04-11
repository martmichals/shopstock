// Class to represent an Item
class Item {
  final int _itemID;
  final String _name;
  final int _categoryID;
  double _confidence;

  // Constructor
  Item(this._itemID, this._name, this._categoryID, this._confidence);

  // Getter methods
  int get itemID => _itemID;
  String get name => _name;
  int get categoryName => _categoryID;
  double get confidence => _confidence;

  // Setter methods
  void set(double confidence) => this._confidence = confidence;

  @override
  String toString() => 'Item $_itemID\nName:$_name';
}
