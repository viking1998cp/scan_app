import 'dart:io';

import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class Classifier {
  Future<List<ImageLabel>> predict(
      File file, int mode, BuildContext context) async {
    if (mode == 1 || mode == 2) {
      ImageLabeler imageLabeler;
      if (Platform.isAndroid) {
        String modelPath = 'bird.tflite';
        if (mode == 2) {
          modelPath = 'mush.tflite';
        }

        await Future.delayed(const Duration(seconds: 1), () {});
        CustomImageLabelerOptions objectDetector = CustomImageLabelerOptions(
            customModel: CustomLocalModel.asset,
            customModelPath: modelPath,
            confidenceThreshold: 0.03,
            maxCount: 5);
        imageLabeler = GoogleMlKit.vision.imageLabeler(objectDetector);
      } else {
        String modelPath = 'bird';
        if (mode == 2) {
          modelPath = 'mush_data';
        }

        CustomRemoteLabelerOption objectDetector = CustomRemoteLabelerOption(
            confidenceThreshold: 0.03, maxCount: 5, modelName: modelPath);
        imageLabeler = GoogleMlKit.vision.imageLabeler(objectDetector);
      }

      InputImage inputImage = InputImage.fromFile(file);
      final result = await imageLabeler.processImage(inputImage);
      imageLabeler.close();

      return result;
    } else {
      DetectRepository detectRepository = DetectRepository();
      String urlDetect = await detectRepository.uploadImage(file);
      List<ImageLabel> imagesData = await detectRepository.detectPlant(
        urlDetect,
      );
      return imagesData;
    }
  }
}
