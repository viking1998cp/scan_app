import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:dio/dio.dart';

class NaturalRepository {
  int currentCount = 0;
  int skip = 0;
  List<String> totalItem = [];

  Future<List<String>> getNameNatural() async {
    Response? responseDog = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_dog_breeds', host: "");
    Response? responseBird = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_birds_by_common_name',
        host: "");
    Response? responseMushroom = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/Category:Lists_of_fungal_species',
        host: "");
    Response? responsePlan = await ServiceCommon.getInstance()!.getHttp(
        api: 'https://en.wikipedia.org/wiki/List_of_plants_by_common_name',
        host: "");

    List<String> dogs =  await StringCommon.naturalHtml(responseDog!.data, 0);
    List<String> birds = await StringCommon.naturalHtml(responseBird!.data, 1);
    List<String> mushrooms = await StringCommon.naturalHtml(responseMushroom!.data,2);
    List<String> plans =  await StringCommon.naturalHtml(responsePlan!.data, 3);

    totalItem.addAll(dogs);
    totalItem.addAll(birds);
    totalItem.addAll(mushrooms);
    totalItem.addAll(plans);
    var randomList = (totalItem..shuffle()).take(totalItem.length).toList();
    return randomList;
  }
}
