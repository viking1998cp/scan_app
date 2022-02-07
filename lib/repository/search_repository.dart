import 'dart:convert';

import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/core/models/search.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:dio/dio.dart';

import 'detect_repository.dart';

class SearchRepository {
  SearchDataModel? _searchDataModel;
  List<Search> listSearch = [];

  DetailSearchModel? _detailNameSearch;
  String name = "";

  Future<SearchDataModel?> getListDataSearch({String? searchName}) async {
    Response? searchResponse = await ServiceCommon.getInstance()!.getHttp(
        api:
            'https://en.wikipedia.org/w/api.php?action=query&list=search&utf8=true&format=json&srsearch=${searchName ?? ""}',
        host: "");

    var data = searchResponse!.data is Map
        ? searchResponse.data
        : json.decode(searchResponse.data);

    _searchDataModel = SearchDataModel.fromJson(data);

    listSearch = _searchDataModel!.query!.search!;

    return _searchDataModel;
  }
}
