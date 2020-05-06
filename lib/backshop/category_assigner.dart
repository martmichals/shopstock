// Class to represent an item category
class CategoryAssigner{
  Map<int, String> _categories;

  // Constructors
  CategoryAssigner(this._categories);
  CategoryAssigner.blank(){_categories = Map();}

  // Method to put a new entry into the map
  void addCategory(int id, String categoryName){
    _categories.putIfAbsent(id, () => categoryName);
  }

  // Getter methods
  Map<int, String> get categories => _categories;

  // Custom getter methods
  List<String> getCategoryNames() => _categories.values;
  String getCategoryByID(int id) => _categories[id];

  // TODO : Implement a method that returns and item dictionary for the UI

  @override
  String toString() {
    var str = 'CATEGORY ASSIGNER: ';
    _categories.forEach((id, name) {str = '$str |id: $id, name: $name|';});
    return str;
  }
}