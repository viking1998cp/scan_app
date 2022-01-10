class SearchDataModel {
  String? batchcomplete;
  Query? query;

  SearchDataModel({this.batchcomplete, this.query});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    batchcomplete = json['batchcomplete'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batchcomplete'] = this.batchcomplete;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    return data;
  }
}

class Query {
  Searchinfo? searchinfo;
  List<Search>? search;

  Query({this.searchinfo, this.search});

  Query.fromJson(Map<String, dynamic> json) {
    searchinfo = json['searchinfo'] != null
        ? new Searchinfo.fromJson(json['searchinfo'])
        : null;
    if (json['search'] != null) {
      search = [];
      json['search'].forEach((v) {
        search!.add(new Search.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchinfo != null) {
      data['searchinfo'] = this.searchinfo!.toJson();
    }
    if (this.search != null) {
      data['search'] = this.search!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Searchinfo {
  int? totalhits;
  String? suggestion;
  String? suggestionsnippet;

  Searchinfo({this.totalhits, this.suggestion, this.suggestionsnippet});

  Searchinfo.fromJson(Map<String, dynamic> json) {
    totalhits = json['totalhits'];
    suggestion = json['suggestion'];
    suggestionsnippet = json['suggestionsnippet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalhits'] = this.totalhits;
    data['suggestion'] = this.suggestion;
    data['suggestionsnippet'] = this.suggestionsnippet;
    return data;
  }
}

class Search {
  int? ns;
  String? title;
  int? pageid;
  int? size;
  int? wordcount;
  String? snippet;
  String? timestamp;

  Search(
      {this.ns,
        this.title,
        this.pageid,
        this.size,
        this.wordcount,
        this.snippet,
        this.timestamp});

  Search.fromJson(Map<String, dynamic> json) {
    ns = json['ns'];
    title = json['title'];
    pageid = json['pageid'];
    size = json['size'];
    wordcount = json['wordcount'];
    snippet = json['snippet'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['pageid'] = this.pageid;
    data['size'] = this.size;
    data['wordcount'] = this.wordcount;
    data['snippet'] = this.snippet;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class DetailSearchModel {
  Titles? titles;
  ContentUrls? contentUrls;
  String? extract;

  DetailSearchModel({this.titles, this.contentUrls, this.extract});

  DetailSearchModel.fromJson(Map<String, dynamic> json) {
    titles =
    json['titles'] != null ? new Titles.fromJson(json['titles']) : null;
    contentUrls = json['content_urls'] != null
        ? new ContentUrls.fromJson(json['content_urls'])
        : null;
    extract = json['extract'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.titles != null) {
      data['titles'] = this.titles!.toJson();
    }
    if (this.contentUrls != null) {
      data['content_urls'] = this.contentUrls!.toJson();
    }
    data['extract'] = this.extract;
    return data;
  }
}

class Titles {
  String? canonical;
  String? display;

  Titles({this.canonical, this.display});

  Titles.fromJson(Map<String, dynamic> json) {
    canonical = json['canonical'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canonical'] = this.canonical;
    data['display'] = this.display;
    return data;
  }
}

class ContentUrls {
  Mobile? mobile;

  ContentUrls({this.mobile});

  ContentUrls.fromJson(Map<String, dynamic> json) {
    mobile =
    json['mobile'] != null ? new Mobile.fromJson(json['mobile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mobile != null) {
      data['mobile'] = this.mobile!.toJson();
    }
    return data;
  }
}

class Mobile {
  String? page;

  Mobile({this.page});

  Mobile.fromJson(Map<String, dynamic> json) {
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    return data;
  }
}