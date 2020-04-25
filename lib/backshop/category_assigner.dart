// Class to represent an item category
class CategoryAssigner{
  // TODO : Change this into a HashMap to speed the lookup process
  // TODO : Create a factory to create these from dynamic JSON
  Map<int, String> _categories;

  // Constructors
  CategoryAssigner(this._categories);

  // Blank constructor
  CategoryAssigner.blank();

  // Getter methods
  Map<int, String> get categories => _categories;

  // Custom getter methods
  List<String> getCategoryNames() => _categories.values;
  String getCategoryByID(int id) => _categories[id];
}