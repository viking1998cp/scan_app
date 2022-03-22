import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:base_flutter_framework/base/base_controller.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/scan_image/view/camera_widget.dart';
import 'package:base_flutter_framework/module/scan_image/view/classifier.dart';
import 'package:base_flutter_framework/module/scan_image/view/list_image_lable.dart';
import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:base_flutter_framework/utils/sk_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScanController extends BaseController {
  static CameraController? cameraController;
  XFile? imageFile;
  DetectRepository repository = new DetectRepository();
  RxInt indexMode = 1.obs;
  RxInt updateCamera = 0.obs;

  ScanController();
  RxList<ResultDetect> dataDetect = <ResultDetect>[].obs;
  late Classifier _classifier = new Classifier();

  Category? category;

  String? stringCodecChannel = 'com.scanthis.plant.identification/message';

  BasicMessageChannel<String>? stringPlatform;

  ImageLabel? imageDog;

  @override
  Future<void> onInit() async {
    super.onInit();

    stringPlatform =
        BasicMessageChannel<String>(stringCodecChannel!, StringCodec());
    stringPlatform!.setMessageHandler(_handleStringPlatformBack);
  }

  static const double THRESHOLD = 0.5;

  Future<void> captureImage() async {
    if (Platform.isIOS && indexMode.value == 4) {
      SKToast.showToastBottom(
          messager: "No support platform", context: Get.context);
      return;
    }
    imageFile = await cameraController!.takePicture();
    cameraController!.resumePreview().then((value) {
      ScanController.cameraController!.setFlashMode(FlashMode.off);
    });

    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: File(imageFile!.path).path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      if (indexMode.value == 4) {
        dataDetect.clear();
        dataDetect.value = [];
        await stringPlatform!.send(imageFile!.path);
      } else {
        datas(croppedFile);
      }

      await Get.to(ListDetectScreen(), arguments: [croppedFile]);
      cameraController!.resumePreview().then((value) {
        Timer(Duration(milliseconds: 500), () {
          ScanController.cameraController!.setFlashMode(
              CameraWidgetState.flashOn ? FlashMode.torch : FlashMode.off);
        });
      });
    }

    // showPreview.value = true;
  }

  Future<void> datas(File file) async {
    dataDetect.value = [];
    List<ImageLabel> result = await detecImage(file);
    repository.getListResult(result, indexMode.value).then((value) {
      dataDetect.value = value;
    });
  }

  Future<void> detectDog(ImageLabel imageLabel) async {
    repository.getListResult([imageLabel], indexMode.value).then((value) {
      dataDetect.value = value;
    });
  }

  Future<List<ImageLabel>> detecImage(File file) async {
    var pred = await _classifier.predict(file, indexMode.value, Get.context!);
    return pred;
  }

  void changeMode(int mode) {
    indexMode.value = mode;
  }

  Future<String> _handleStringPlatformBack(String? response) async {
    imageDog = null;
    print(response);
    if (response != null) {
      List jsonData = jsonDecode(response);
      Map<String, dynamic> data = HashMap();
      data.putIfAbsent('confidence', () => jsonData[0]['percentageAccuracy']);

      String nameDog = await getAllNameDog(
          jsonData[0]['latinNameUnderscored'], Get.context!);
      data.putIfAbsent('text', () => nameDog);
      data.putIfAbsent('index', () => 0);

      imageDog = ImageLabel(data);
      await Future.delayed(Duration(milliseconds: 1000), () async {
        detectDog(imageDog!);
      });
    } else {
      dataDetect.clear();
      dataDetect.add(ResultDetect(title: "Not found", displaytitle: "None"));
    }

    return "";
  }

  Future<String> getAllNameDog(String name, BuildContext context) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "asset_database.db");
    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
    var db = await openDatabase(path);

    dynamic results = await db.rawQuery(
        'SELECT name FROM alias WHERE language="${ui.window.locale.languageCode}" and isMainName = 1 and breed_id = (SELECT breed_id FROM alias WHERE name LIKE "%$name%" LIMIT 1)');
    if (results.toString() != "[]")
      return results[0].row[0];
    else
      return "";
  }
}
