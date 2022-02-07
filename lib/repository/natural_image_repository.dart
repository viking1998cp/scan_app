import 'dart:math';

import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:dio/dio.dart';

import 'detect_repository.dart';

class NaturalRepository {
  int currentCount = 0;
  int skip = 0;
  List<String> totalItem = [];
  DetectRepository _detectRepository = new DetectRepository();

  Future<List<String>> getNameNatural() async {
    Response? responseDog = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_dog_breeds', host: "");
    Response? responseBird = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_birds_by_common_name',
        host: "");
    Response? responseMushroom = await ServiceCommon.getInstance()!.getHttp(
        api:
            'https://en.wikipedia.org/wiki/List_of_North_American_Tricholoma_species',
        host: "");
    Response? responsePlan = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_plants_by_common_name',
        host: "");

    List<String> dogs = StringCommon.naturalHtml(responseDog!.data);
    List<String> birds = StringCommon.naturalHtml(responseBird!.data);
    List<String> mushrooms = StringCommon.naturalHtml(responseMushroom!.data);
    List<String> plans = StringCommon.naturalHtml(responsePlan!.data);

    totalItem.addAll(dogs);
    totalItem.addAll(birds);
    totalItem.addAll(mushrooms);
    totalItem.addAll(plans);
    var randomList = (totalItem..shuffle()).take(totalItem.length).toList();
    return randomList;
  }
}
