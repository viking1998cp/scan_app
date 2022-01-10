import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class ServiceCommon {
  static ServiceCommon? instance;
  final String configUrl = "http://192.168.1.112:8004/config";
  final String getDetail = 'https://en.wikipedia.org/api/rest_v1/page/summary/';
  final String hostUploadImage = 'https://api.plantnet.org/v1/images';
  final String apiDetectPlant = 'https://my-api.plantnet.org/v2/identify/all';
  // final String modeArticle

  static ServiceCommon? getInstance() {
    if (instance == null) instance = new ServiceCommon();
    return instance;
  }

  Future<Response?> getHttp(
      {Map<String, dynamic>? param,
      required String api,
      required String host,
      bool? cancelRequest}) async {
    // await Dio(options)?.clear();
    jsonEncode(param);
    Response? response;
    try {
      Dio dio = new Dio(_baseOptionsFromToken());
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            request.headers['Accept'] = "application/json";
            request.headers['Content-type'] = "application/json";

            return handler.next(request);
          },
          onError: (e, handler) async {
            if (e.response?.statusCode == 404) {
              response = null;
              handler.resolve(Response(
                  requestOptions: RequestOptions(path: host + api),
                  data: {
                    "type":
                        "https://mediawiki.org/wiki/HyperSwitch/errors/not_found",
                    "title": "Not found.",
                    "method": "get",
                    "detail": "Page or revision not found.",
                    "uri":
                        "/vi.wikipedia.org/v1/page/summary/Amanita_muscaria_flavivolvata"
                  }));
              return;
            }
          },
        ),
      );
      response = await dio
          .get(
            host + api,
            queryParameters: param,
          )
          .catchError((_e) {});
      if (response!.statusCode == 404) {
        return null;
      }
      return response;
    } on DioError catch (e) {
      return null;
    }
  }

  Future<Response?> postHttp({
    Map<String, dynamic>? param,
    required String api,
    required String host,
  }) async {
    jsonEncode(param);
    Dio dio = getApiClient();
    Response response = await dio.post(host + api, data: param);

    return response;
  }

  Future<Response?> put({
    Map<String, dynamic>? param,
    required String api,
    required String host,
  }) async {
    Dio dio = getApiClient();

    Response response = await dio.put(host + api, data: param);
    return response;
  }

  Future<Response?> patch({
    Map<String, dynamic>? param,
    required String api,
    required String host,
  }) async {
    Dio dio = getApiClient();
    Response response = await dio.patch(host + api,
        // queryParameters: param,
        data: param);

    return response;
  }

  Future<Response?> deleteHttp(
      {Map<String, dynamic>? param,
      required String host,
      required String api}) async {
    Dio dio = getApiClient();

    Response response = await dio.delete(host + api, data: param);
    return response;
  }

  Future<Response?> patchHttp(
      {required Map<String, dynamic> param,
      required String host,
      required String api}) async {
    Dio dio = getApiClient();
    Response response = await dio.patch(host + api, data: param);
    return response;
  }

  Future<Response?> upLoadImageFile({
    required Map<String, dynamic>? param,
    required File file,
    required String fileName,
  }) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 90,
        targetWidth: 1200,
        targetHeight: (properties.height! * 1200 / properties.width!).round());

    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(compressedFile.path, filename: fileName),
    });
    Dio dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 600000, // 60 seconds
        receiveTimeout: 600000, // 60 seconds

        headers: {
          // 'Content-Type': 'image/*',
          // 'Content-Length': File(compressedFile.path).lengthSync().toString(),
          'Accept': 'application/json',
          HttpHeaders.userAgentHeader:
              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
        }));
    Response response = await dio.post(
      ServiceCommon.getInstance()!.hostUploadImage,
      data: formData,
    );

    return response;
  }

  BaseOptions _baseOptionsFromToken() {
    return BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 600000, // 60 seconds
        receiveTimeout: 600000, // 60 seconds
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        });
  }

  Dio getApiClient() {
    Dio dio = new Dio(_baseOptionsFromToken());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          request.headers['Accept'] = "application/json";
          request.headers['Content-type'] = "application/json";

          return handler.next(request);
        },
        onError: (e, handler) async {
          if (e.response?.statusCode == 404) {
            return null;
          }
        },
      ),
    );

    return dio;
  }
}
