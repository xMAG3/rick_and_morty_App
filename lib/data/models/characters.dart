class Character {
  late int id;
  late String name;
  late String status;
  late String species;
  late String location;
  late String image;
  late  List<dynamic> episode;

  Character.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    location = json['location']['name'];
    image = json['image'];
  }
}
