import 'dart:io';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/camera_widget.dart';
import 'package:base_flutter_framework/module/scan_image/view/list_image_lable.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_cropper/image_cropper.dart';

class ScanScreen extends GetView<ScanController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Container(
      child: Scaffold(
          body: Container(
              child: Column(
        children: [
          Obx(() => CameraWidget(
                showButtonCap: Get.arguments != null ? true : false,
                selectImageFromGallery: (file) async {
                  File? croppedFile = await ImageCropper.cropImage(
                      sourcePath: file.path,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ],
                      androidUiSettings: AndroidUiSettings(
                          toolbarTitle: TransactionKey.loadLanguage(
                              context, TransactionKey.cropper),
                          toolbarColor: Colors.deepOrange,
                          toolbarWidgetColor: Colors.white,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      iosUiSettings: IOSUiSettings(
                        minimumAspectRatio: 1.0,
                      ));
                  if (croppedFile != null) {
                    if (controller.indexMode.value == 4) {
                      controller.dataDetect.clear();
                      controller.dataDetect.value = [];

                      await controller.stringPlatform!.send(croppedFile.path);
                    } else {
                      controller.datas(croppedFile);
                    }

                    Get.to(ListDetectScreen(), arguments: [croppedFile]);
                  }
                },
                changeMode: (int mode) {
                  controller.changeMode(mode);
                },
                indexMode: controller.indexMode.value,
              ))
        ],
      ))),
    );
  }
}
