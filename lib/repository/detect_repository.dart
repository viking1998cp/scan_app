import 'dart:collection';
import 'dart:io';

import 'package:base_flutter_framework/core/models/plant_detect.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:dio/dio.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui' as ui;

class DetectRepository {
  Future<List<ResultDetect>> getListResult(List<ImageLabel> data) async {
    List<ResultDetect> dataDetect = [];
    data.forEach((element) async {});
    for (int i = 0; i < data.length; i++) {
      if (!data[i].label.contains('found')) {
        ResultDetect resultDetect = await getResultByName(data[i].label);
        if (!resultDetect.title!.contains('Not found') &&
            !resultDetect.displaytitle!.contains('None')) {
          resultDetect.point = (data[i].confidence * 100).round();
          dataDetect.add(resultDetect);
        }
      }
    }
    if (dataDetect.isEmpty) {
      dataDetect.add(ResultDetect(title: 'Not found'));
    }

    return dataDetect;
  }

  Future<ResultDetect> getResultByName(String name, {String? locace}) async {
    try {
      Response? response = await ServiceCommon.getInstance()!.getHttp(
          api: name.replaceAll(" ", "_"),
          host:
              'https://${locace ?? ui.window.locale.languageCode}.wikipedia.org/api/rest_v1/page/summary/');
      print(response!.data);
      return ResultDetect.fromJson(response.data);
    } catch (_e) {
      ResultDetect resultDetect =
          ResultDetect(title: "Not found", displaytitle: "None");
      return resultDetect;
    }
  }

  Future<String> uploadImage(File model) async {
    Response? response = await ServiceCommon.getInstance()!
        .upLoadImageFile(file: model, param: {}, fileName: "model");
    return "https://bs.plantnet.org/v1/image/o/${response!.data["id"]}";
  }

  Future<List<ImageLabel>> detectPlant(String urlModel) async {
    Map<String, dynamic> param = HashMap();
    param.putIfAbsent('api-key', () => '2b10tQGE4oZTe8r23CjDhFnAe');
    param.putIfAbsent('images', () => urlModel);
    param.putIfAbsent('images', () => urlModel);
    param.putIfAbsent('organs', () => 'flower');
    param.putIfAbsent('organs', () => 'leaf');

    Response? response = await ServiceCommon.getInstance()!
        .getHttp(api: "", host: ServiceCommon().apiDetectPlant, param: param);
    if (response!.data == null) return [];
    List data = response.data['results'];
    List<PlantDetect> plantDetects = [];
    data.forEach((element) {
      plantDetects.add(PlantDetect.fromJson(element));
    });
    List<ImageLabel> results = [];

    plantDetects.forEach((element) {
      if (element.score! > 0.03) {
        Map<String, dynamic> data = HashMap();
        data.putIfAbsent('confidence', () => element.score!);
        data.putIfAbsent(
            'text', () => element.species!.family!.scientificName!);
        data.putIfAbsent('index', () => 0);
        results.add(ImageLabel(data));
      }
    });
    return results;
  }
}
