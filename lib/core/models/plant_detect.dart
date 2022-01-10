class PlantDetect {
  double? score;
  Species? species;
  Gbif? gbif;

  PlantDetect({this.score, this.species, this.gbif});

  PlantDetect.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
    gbif = json['gbif'] != null ? new Gbif.fromJson(json['gbif']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    if (this.species != null) {
      data['species'] = this.species!.toJson();
    }
    if (this.gbif != null) {
      data['gbif'] = this.gbif!.toJson();
    }
    return data;
  }
}

class Species {
  String? scientificNameWithoutAuthor;
  String? scientificNameAuthorship;
  Genus? genus;
  Genus? family;
  List<String>? commonNames;
  String? scientificName;

  Species(
      {this.scientificNameWithoutAuthor,
      this.scientificNameAuthorship,
      this.genus,
      this.family,
      this.commonNames,
      this.scientificName});

  Species.fromJson(Map<String, dynamic> json) {
    scientificNameWithoutAuthor = json['scientificNameWithoutAuthor'];
    scientificNameAuthorship = json['scientificNameAuthorship'];
    genus = json['genus'] != null ? new Genus.fromJson(json['genus']) : null;
    family = json['family'] != null ? new Genus.fromJson(json['family']) : null;
    commonNames = json['commonNames'].cast<String>();
    scientificName = json['scientificName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scientificNameWithoutAuthor'] = this.scientificNameWithoutAuthor;
    data['scientificNameAuthorship'] = this.scientificNameAuthorship;
    if (this.genus != null) {
      data['genus'] = this.genus!.toJson();
    }
    if (this.family != null) {
      data['family'] = this.family!.toJson();
    }
    data['commonNames'] = this.commonNames;
    data['scientificName'] = this.scientificName;
    return data;
  }
}

class Genus {
  String? scientificNameWithoutAuthor;
  String? scientificNameAuthorship;
  String? scientificName;

  Genus(
      {this.scientificNameWithoutAuthor,
      this.scientificNameAuthorship,
      this.scientificName});

  Genus.fromJson(Map<String, dynamic> json) {
    scientificNameWithoutAuthor = json['scientificNameWithoutAuthor'];
    scientificNameAuthorship = json['scientificNameAuthorship'];
    scientificName = json['scientificName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scientificNameWithoutAuthor'] = this.scientificNameWithoutAuthor;
    data['scientificNameAuthorship'] = this.scientificNameAuthorship;
    data['scientificName'] = this.scientificName;
    return data;
  }
}

class Gbif {
  String? id;

  Gbif({this.id});

  Gbif.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
