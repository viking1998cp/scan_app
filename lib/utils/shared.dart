import 'dart:convert';

import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/core/models/user.dart';
import 'package:base_flutter_framework/utils/string.dart';

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

//cache file
class Shared {
  static Shared? instance;
  static Shared getInstance() {
    if (instance == null) {
      instance = new Shared();
    }
    return instance!;
  }

  String? version;

  int? colorPrimary;

  //==1 bottom
  //==2 screen
  int? layout;
  String? deviceId;

  List<ResultDetect>? collectionCache;
  List<ResultDetect>? favoriteCache;

  // List<Article>? niceArticleData = [];

  Future<void> saveFavorite({required List<ResultDetect> cacheFavorite}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(StringCommon.keyFavorite,
        jsonEncode(ResultDetect.encode(cacheFavorite)));
  }

  Future<bool> getLikeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(StringCommon.keyFavorite)) {
      String data = preferences.getString(StringCommon.keyFavorite)!;

      favoriteCache = ResultDetect.decode(jsonDecode(data));
      return true;
    } else {
      favoriteCache = [];
    }
    return false;
  }

  Future<void> saveCollection(
      {required List<ResultDetect> cacheCollection}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(StringCommon.keyCollection,
        jsonEncode(ResultDetect.encode(cacheCollection)));
    print(cacheCollection);
  }

  Future<bool> getCollection() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(StringCommon.keyCollection)) {
      String data = preferences.getString(StringCommon.keyCollection)!;

      collectionCache = ResultDetect.decode(jsonDecode(data));
      return true;
    } else {
      collectionCache = [];
    }
    return false;
  }

  Future<void> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  Future<bool> saveColorPrimary({required int color}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(StringCommon.keyColor, color);
    return true;
  }

  Future<int> getColor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(StringCommon.keyColor)) {
      colorPrimary = preferences.getInt(StringCommon.keyColor);
    } else {
      colorPrimary = 0xFFFF6464;
    }

    return colorPrimary!;
  }

  Future<bool> saveLayOutScreen({required int layout}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.layout = layout;
    await preferences.setInt(StringCommon.keyLayOut, layout);
    return true;
  }

  Future<int> getLayOutScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(StringCommon.keyLayOut)) {
      layout = preferences.getInt(StringCommon.keyLayOut);
    } else {
      layout = 1;
    }

    return layout!;
  }

  Future<bool> saveDeviceId({required String deviceId}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(StringCommon.keyDeviceId, deviceId);
    return true;
  }

  Future<String> getDeviceId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(StringCommon.keyDeviceId)) {
      deviceId = preferences.getString(StringCommon.keyDeviceId);
    }
    deviceId = "65c8f4e9b168de606af6332ca0a631b7";
    return deviceId!;
  }
}
