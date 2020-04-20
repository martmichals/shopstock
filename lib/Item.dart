class Item {
  String name;
  double confidence;
  static var items = <String>[
    "Bread",
    "Eggs",
    "Cheese",
    "Lettuce",
    "Apples"
  ];

  Item(String name, double confidence) {
    this.name = name;
    this.confidence = confidence;
  }
}