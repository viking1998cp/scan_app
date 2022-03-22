import 'dart:convert';

class ResultDetect {
  String? type;
  String? title;
  String? displaytitle;
  Namespace? namespace;
  String? wikibaseItem;
  Titles? titles;
  int? pageid;
  Thumbnail? thumbnail;
  Thumbnail? originalimage;
  String? lang;
  String? dir;
  String? revision;
  String? tid;
  String? timestamp;
  String? description;
  String? descriptionSource;
  ContentUrls? contentUrls;
  String? extract;
  String? extractHtml;
  int? point;
  bool? isLike;

  ResultDetect(
      {this.type,
      this.title,
      this.displaytitle,
      this.namespace,
      this.wikibaseItem,
      this.titles,
      this.pageid,
      this.thumbnail,
      this.originalimage,
      this.lang,
      this.dir,
      this.revision,
      this.tid,
      this.timestamp,
      this.description,
      this.descriptionSource,
      this.contentUrls,
      this.extract,
      this.extractHtml,
      this.point});

  ResultDetect copy() {
    return ResultDetect(
      type: type,
      title: this.title,
      displaytitle: this.displaytitle,
      namespace: this.namespace,
      wikibaseItem: this.wikibaseItem,
      titles: this.titles,
      pageid: this.pageid,
      thumbnail: this.thumbnail,
      originalimage: this.originalimage,
      lang: this.lang,
      dir: this.dir,
      revision: this.revision,
      tid: this.tid,
      timestamp: this.timestamp,
      description: this.description,
      descriptionSource: this.descriptionSource,
      contentUrls: this.contentUrls,
      extract: this.extract,
      extractHtml: this.extractHtml,
      point: this.point,
    );
  }

  ResultDetect.fromJson(Map<String, dynamic> json) {
    bool like = false;

    isLike = like;
    type = json['type'];
    title = json['title'];
    displaytitle = json['displaytitle'];
    namespace = json['namespace'] != null
        ? new Namespace.fromJson(json['namespace'])
        : null;
    wikibaseItem = json['wikibase_item'];
    titles =
        json['titles'] != null ? new Titles.fromJson(json['titles']) : null;
    pageid = json['pageid'];
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    originalimage = json['originalimage'] != null
        ? new Thumbnail.fromJson(json['originalimage'])
        : null;
    lang = json['lang'];
    dir = json['dir'];
    revision = json['revision'];
    tid = json['tid'];
    timestamp = json['timestamp'];
    description = json['description'];
    descriptionSource = json['description_source'];
    contentUrls = json['content_urls'] != null
        ? new ContentUrls.fromJson(json['content_urls'])
        : null;
    extract = json['extract'];
    extractHtml = json['extract_html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['displaytitle'] = this.displaytitle;
    if (this.namespace != null) {
      data['namespace'] = this.namespace!.toJson();
    }
    data['wikibase_item'] = this.wikibaseItem;
    if (this.titles != null) {
      data['titles'] = this.titles!.toJson();
    }
    data['pageid'] = this.pageid;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }
    if (this.originalimage != null) {
      data['originalimage'] = this.originalimage!.toJson();
    }
    data['lang'] = this.lang;
    data['dir'] = this.dir;
    data['revision'] = this.revision;
    data['tid'] = this.tid;
    data['timestamp'] = this.timestamp;
    data['description'] = this.description;
    data['description_source'] = this.descriptionSource;
    if (this.contentUrls != null) {
      data['content_urls'] = this.contentUrls!.toJson();
    }
    data['extract'] = this.extract;
    data['extract_html'] = this.extractHtml;
    return data;
  }

  static String encode(List<ResultDetect> resultDetects) => json.encode(
        resultDetects
            .map<Map<String, dynamic>>((resultDetect) => resultDetect.toJson())
            .toList(),
      );

  static List<ResultDetect> decode(String data) =>
      (json.decode(data) as List<dynamic>)
          .map<ResultDetect>((item) => ResultDetect.fromJson(item))
          .toList();
}

class Namespace {
  int? id;
  String? text;

  Namespace({this.id, this.text});

  Namespace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    return data;
  }
}

class Titles {
  String? canonical;
  String? normalized;
  String? display;

  Titles({this.canonical, this.normalized, this.display});

  Titles.fromJson(Map<String, dynamic> json) {
    canonical = json['canonical'];
    normalized = json['normalized'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canonical'] = this.canonical;
    data['normalized'] = this.normalized;
    data['display'] = this.display;
    return data;
  }
}

class Thumbnail {
  String? source;
  int? width;
  int? height;

  Thumbnail({this.source, this.width, this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class ContentUrls {
  Desktop? desktop;
  Desktop? mobile;

  ContentUrls({this.desktop, this.mobile});

  ContentUrls.fromJson(Map<String, dynamic> json) {
    desktop =
        json['desktop'] != null ? new Desktop.fromJson(json['desktop']) : null;
    mobile =
        json['mobile'] != null ? new Desktop.fromJson(json['mobile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.desktop != null) {
      data['desktop'] = this.desktop!.toJson();
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile!.toJson();
    }
    return data;
  }
}

class Desktop {
  String? page;
  String? revisions;
  String? edit;
  String? talk;

  Desktop({this.page, this.revisions, this.edit, this.talk});

  Desktop.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    revisions = json['revisions'];
    edit = json['edit'];
    talk = json['talk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['revisions'] = this.revisions;
    data['edit'] = this.edit;
    data['talk'] = this.talk;
    return data;
  }
}
