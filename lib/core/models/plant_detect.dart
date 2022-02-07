class PlantDetect {
  double? score;
  List<Images>? images;
  Species? species;

  PlantDetect({this.score, this.images, this.species});

  PlantDetect.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    return data;
  }
}

class Images {
  String? id;
  String? o;
  String? m;
  String? s;
  String? organ;
  String? author;
  String? date;
  String? license;

  Images(
      {this.id,
      this.o,
      this.m,
      this.s,
      this.organ,
      this.author,
      this.date,
      this.license});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    o = json['o'];
    m = json['m'];
    s = json['s'];
    organ = json['organ'];
    author = json['author'];
    date = json['date'];
    license = json['license'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['o'] = this.o;
    data['m'] = this.m;
    data['s'] = this.s;
    data['organ'] = this.organ;
    data['author'] = this.author;
    data['date'] = this.date;
    data['license'] = this.license;
    return data;
  }
}

class Species {
  String? name;
  String? author;
  String? family;
  String? genus;
  List<String>? commonNames;

  Species({this.name, this.author, this.family, this.genus, this.commonNames});

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    family = json['family'];
    genus = json['genus'];
    commonNames = json['commonNames'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['author'] = this.author;
    data['family'] = this.family;
    data['genus'] = this.genus;
    data['commonNames'] = this.commonNames;
    return data;
  }
}
