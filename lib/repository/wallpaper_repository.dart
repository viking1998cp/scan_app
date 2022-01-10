import 'dart:convert';

import 'package:async/async.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/core/models/wallpaper.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:dio/dio.dart';


class WallpaperRepository {
  List<WallpaperId> listWallpaperIds = [];

  WallpaperModel? _wallpaperModel;
  String? deviceId = "";

  Future<String> _getDeviceId() async {
    return deviceId = await Shared.getInstance().getDeviceId();
  }

  Future<WallpaperModel?> getListWallpaperIds({required String name, int? pageCount}) async {
    await _getDeviceId();

    var response = await Dio().get('https://7fon.org/app/api.php?spn=${pageCount??0}&dev=tel&tip=sch&sch=$name&lang=en&user=$deviceId');

    var data = response.data is Map ? response.data : json.decode(response.data);

    _wallpaperModel = WallpaperModel.fromJson(data);

    listWallpaperIds = _wallpaperModel!.id!;

    return _wallpaperModel;
  }

  // Future<List<String>> getListWallpapers({required String wallpaperName}) async {
  //   await getListWallpaperIds(name: wallpaperName);
  //
  //   for (var i = 1; i < listWallpaperIds.length; i++) {
  //     Response? responseWallpapers = await ServiceCommon.getInstance()!.getHttp(
  //         api: 'http://i.7fon.org/300/${listWallpaperIds[i].id}.jpg', host: "");
  //     listWallpapers.add(responseWallpapers!.data);
  //   }
  //   return listWallpapers;
  // }
}
