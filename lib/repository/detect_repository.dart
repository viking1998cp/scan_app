import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:base_flutter_framework/core/models/plant_detect.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:dio/dio.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class DetectRepository {
  Future<List<ResultDetect>> getListResult(
      List<ImageLabel> data, int indexMode) async {
    List<ResultDetect> dataDetect = [];
    data.forEach((element) async {});
    for (int i = 0; i < data.length; i++) {
      if (!data[i].label.contains('found')) {
        ResultDetect resultDetect = await getResultByName(data[i].label,
            locace: indexMode == 3 ? "en" : null);
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

      return ResultDetect.fromJson(response!.data);
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
    List dataIMage = [];
    dataIMage.add({"url": urlModel});
    param.putIfAbsent('images', () => dataIMage);

    Response? response = await ServiceCommon.getInstance()!
        .postHttp(api: "", host: ServiceCommon().apiDetectPlant, param: param);
    if (response!.data["title"] == "Not found.") return [];
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
        data.putIfAbsent('text', () => element.species!.commonNames!.first);
        data.putIfAbsent('index', () => 0);

        results.add(ImageLabel(data));
      }
    });
    return results;
  }
}
