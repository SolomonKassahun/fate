class RestaurantsModel {
  int id;
  String name;
  String cuisine;
  RestaurantsModel(
      {required this.id, required this.name, required this.cuisine});
  RestaurantsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cuisine = json['cuisine'];
}
