import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:sqflite/sqflite.dart';
import 'package:tflite/tflite.dart';

import 'package:path/path.dart';

class Classifier {
  Future<List<ImageLabel>> predict(
      File file, int mode, BuildContext context) async {
    if (mode == 1 || mode == 2) {
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

      ImageLabeler imageLabeler =
          GoogleMlKit.vision.imageLabeler(objectDetector);

      InputImage inputImage = InputImage.fromFile(file);
      final result = await imageLabeler.processImage(inputImage);
      imageLabeler.close();
      return result;
    } else if (mode == 4) {
      await Tflite.loadModel(
          model: 'assets/tflite/model.tflite',
          labels: 'assets/tflite/labels.txt',
          useGpuDelegate: false);
      var resultList = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.03,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      print(resultList);

      List<ImageLabel> imagesData = [];
      if (resultList != null) {
        resultList.forEach((element) {
          String name = element['label'];
          List nameFormat = name.split(" ");
          name = "";
          for (int i = 1; i < nameFormat.length; i++) {
            name += nameFormat[i] + " ";
          }

          Map<String, dynamic> data = HashMap();
          data.putIfAbsent('confidence', () => element['confidence']);
          data.putIfAbsent('text', () => name.trim());
          data.putIfAbsent('index', () => 0);
          imagesData.add(ImageLabel(data));
        });
      }
      List<ImageLabel> imagesDataFormatName = [];
      for (int i = 0; i < imagesData.length; i++) {
        Map<String, dynamic> data = HashMap();
        data.putIfAbsent('confidence', () => imagesData[i].confidence);
        String nameFormat = await getAllNameDog(imagesData[i].label, context);
        data.putIfAbsent('text', () => nameFormat);
        data.putIfAbsent('index', () => 0);
        imagesDataFormatName.add(ImageLabel(data));
      }

      for (int i = 0; i < imagesDataFormatName.length; i++) {
        String name = imagesDataFormatName[i].label;
        for (int j = 1; j < imagesDataFormatName.length; j++) {
          if (imagesDataFormatName[j].label == name) {
            imagesDataFormatName.removeAt(j);
            continue;
          }
        }
      }
      return imagesDataFormatName;
    } else {
      DetectRepository detectRepository = DetectRepository();
      String urlDetect = await detectRepository.uploadImage(file);
      List<ImageLabel> imagesData = await detectRepository.detectPlant(
        urlDetect,
      );
      return imagesData;
    }
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

    return results[0].row[0];
  }
}
