// Class to represent an Item
class Item {
  final int _id;
  final String _name;
  final int _categoryID;
  double _labelling;

  // Constructors
  Item(this._id, this._name, this._categoryID);
  Item.full(this._id, this._name, this._categoryID, this._labelling);

  // Factory to create item from JSON
  factory Item.fromJson(dynamic json){
    return Item(json['id'] as int, json['name'] as String, json['item-category'] as int);
  }

  // Getter methods
  int get id => _id;
  String get name => _name;
  int get categoryID => _categoryID;
  double get labelling => _labelling;

  // Setter methods
  void setLabelling(double labelling) => this._labelling = labelling;

  @override
  String toString() => 'Item $_id\nName:$_name';
}
