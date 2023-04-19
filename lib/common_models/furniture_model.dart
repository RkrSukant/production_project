class FurnitureModel{
  int id;
  String title;
  String category;
  double price;
  String desc;
  List<String> rooms;
  List<String> imageNames;

  FurnitureModel({required this.id, required this.title, required this.category, required this.price, required this.desc, required this.rooms, required this.imageNames});
}