import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:base_flutter_framework/base/base_controller.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/main.dart';
import 'package:base_flutter_framework/module/scan_image/view/camera_widget.dart';
import 'package:base_flutter_framework/module/scan_image/view/classifier.dart';
import 'package:base_flutter_framework/module/scan_image/view/list_image_lable.dart';
import 'package:base_flutter_framework/repository/detect_repository.dart';

import 'package:camera/camera.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;

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
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  static const double THRESHOLD = 0.5;

  Future<void> captureImage() async {
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

    datas(croppedFile == null ? File(imageFile!.path) : croppedFile);

    await Get.to(ListDetectScreen(),
        arguments: [croppedFile == null ? File(imageFile!.path) : croppedFile]);
    cameraController!.resumePreview().then((value) {
      Timer(Duration(milliseconds: 500), () {
        ScanController.cameraController!.setFlashMode(
            CameraWidgetState.flashOn ? FlashMode.torch : FlashMode.off);
      });
    });

    // showPreview.value = true;
  }

  Future<void> datas(File file) async {
    dataDetect.value = [];
    List<ImageLabel> result = await detecImage(file);
    repository.getListResult(result).then((value) {
      dataDetect.value = value;
    });
  }

  Future<List<ImageLabel>> detecImage(File file) async {
    var pred = await _classifier.predict(file, indexMode.value, Get.context!);
    return pred;
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  Uint8List imageToByteListFloat32Ver2(img.Image image, int inputSize) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel) / 255.0;
        buffer[pixelIndex++] = img.getGreen(pixel) / 255.0;
        buffer[pixelIndex++] = img.getBlue(pixel) / 255.0;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  void changeMode(int mode) {
    indexMode.value = mode;
  }
}
