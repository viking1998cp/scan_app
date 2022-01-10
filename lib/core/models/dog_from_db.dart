class DogFromDb {
  String id;
  String name;
  String breedId;
  DogFromDb({required this.breedId, required this.id, required this.name});

  static DogFromDb fromJson(Map<String, dynamic> map) {
    return DogFromDb(
        breedId: map['breed_id'], id: map['_id'], name: map['name']);
  }
}
