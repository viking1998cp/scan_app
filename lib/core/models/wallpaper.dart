class WallpaperModel {
  List<WallpaperId>? id;
  int? max;

  WallpaperModel({this.id, this.max});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = [];
      json['id'].forEach((v) {
        id!.add(new WallpaperId.fromJson(v));
      });
    }
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.map((v) => v.toJson()).toList();
    }
    data['max'] = this.max;
    return data;
  }
}

class WallpaperId {
  dynamic? id;
  dynamic? like;
  dynamic? top;
  dynamic? down;

  WallpaperId({this.id, this.like, this.top, this.down});

  WallpaperId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    like = json['like'];
    top = json['top'];
    down = json['down'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['like'] = this.like;
    data['top'] = this.top;
    data['down'] = this.down;
    return data;
  }
}
