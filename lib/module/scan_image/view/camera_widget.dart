import 'dart:async';
import 'dart:io';

import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/icons/app_icons.dart';
import 'package:base_flutter_framework/main.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  bool? showButtonCap;
  Function(File file) selectImageFromGallery;
  Function(int mode) changeMode;
  int indexMode;
  CameraWidget(
      {Key? key,
      required this.selectImageFromGallery,
      required this.changeMode,
      required this.indexMode,
      this.showButtonCap})
      : super(key: key);

  @override
  CameraWidgetState createState() => CameraWidgetState();
}

class CameraWidgetState extends State<CameraWidget> {
  int cameraIndex = 0;
  static bool flashOn = false;
  bool showCamera = false;

  void initState() {
    super.initState();
    setUpCamera();
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        showCamera = true;
      });
    });
  }

  @override
  void dispose() {
    ScanController.cameraController!.dispose();
    super.dispose();
  }

  Future<void> setUpCamera() async {
    await new Future.delayed(new Duration(milliseconds: 200), () {
      ScanController.cameraController = CameraController(
        cameras![cameraIndex],
        ResolutionPreset.max,
      );
    });

    ScanController.cameraController!.initialize().then((value) {
      ScanController.cameraController!
          .setFlashMode(flashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    });
  }

  Widget captureCamera(BuildContext context) {
    return ScanController.cameraController == null
        ? Container(
            color: Colors.black,
          )
        : Container(
            color: Colors.black,
            height: (Shared.getInstance().layout == 1 &&
                    widget.showButtonCap != true)
                ? DimensCommon.sizeHeight(context: context) - 112
                : DimensCommon.sizeHeight(context: context),
            child: AspectRatio(
                aspectRatio: ScanController.cameraController!.value.aspectRatio,
                child: CameraPreview(ScanController.cameraController!)),
          );
  }

  Widget buttonCapture() {
    return Visibility(
      visible:
          (Shared.getInstance().layout == 2 || widget.showButtonCap == true),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          child: imageFromLocale(url: AppIcons.iconCapture),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            ScanController controller = Get.find<ScanController>();
            controller.captureImage();
          },
          //params
        ),
      ),
    );
  }

  Widget toolbar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 8,
      title: Text(
        TransactionKey.loadLanguage(Get.context!, TransactionKey.picture)
            .toUpperCase(),
        style: TextAppStyle().textToolBar(),
      ),
      actions: [
        Row(
          children: [
            InkWell(
                onTap: () async {
                  setState(() {
                    cameraIndex == 0 ? cameraIndex = 1 : cameraIndex = 0;
                  });
                  setUpCamera();

                  // await controller.onInit();
                },
                child: imageFromLocale(url: ResourceIcon.iconChangeCamera)),
            const SizedBox(width: 20),
            InkWell(
                onTap: () async {
                  flashOn = !flashOn;
                  // Turn the lamp on:
                  /// Returns a singleton with the controller that you had initialized
                  await ScanController.cameraController!
                      .setFlashMode(flashOn ? FlashMode.torch : FlashMode.off);
                  setState(() {});
                },
                child: imageFromLocale(
                    url: flashOn
                        ? ResourceIcon.iconFlashOn
                        : ResourceIcon.iconFlash,
                    width: 25,
                    height: 25)),
            const SizedBox(width: 20),
            InkWell(
                onTap: () async {
                  final ImagePicker _picker = ImagePicker();
                  PickedFile? media =
                      await _picker.getImage(source: ImageSource.gallery);
                  if (media != null) {
                    widget.selectImageFromGallery(File(media.path));
                  }
                },
                child: imageFromLocale(url: ResourceIcon.iconGallery)),
            const SizedBox(width: 12),
          ],
        )
      ],
    );
  }

  Widget itemMode(String urlIcon, Function() onclick) {
    return InkWell(
      onTap: () {
        onclick();
      },
      child: imageFromLocale(
        url: urlIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ScanController.cameraController == null) {
      return Container();
    }
    if (!ScanController.cameraController!.value.isInitialized) {
      return Container();
    }
    return Column(
      children: [
        toolbar(context),
        Container(
            height: (Shared.getInstance().layout == 1 &&
                    widget.showButtonCap != true)
                ? DimensCommon.sizeHeight(context: context) - 112
                : DimensCommon.sizeHeight(context: context) - 110,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                showCamera == true ? captureCamera(context) : Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          itemMode(
                              widget.indexMode == 1
                                  ? ResourceIcon.iconBirdSelect
                                  : ResourceIcon.iconBird, () {
                            widget.changeMode(1);
                          }),
                          SizedBox(width: 20),
                          itemMode(
                              widget.indexMode == 2
                                  ? ResourceIcon.iconMushSelect
                                  : ResourceIcon.iconMushroom, () {
                            widget.changeMode(2);
                          }),
                          SizedBox(width: 20),
                          itemMode(
                              widget.indexMode == 3
                                  ? ResourceIcon.iconPlantSelect
                                  : ResourceIcon.iconPlant, () {
                            widget.changeMode(3);
                          }),
                          SizedBox(width: 20),
                          itemMode(
                              widget.indexMode == 4
                                  ? ResourceIcon.iconDogSelect
                                  : ResourceIcon.iconPet, () {
                            widget.changeMode(4);
                          }),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    buttonCapture()
                  ],
                )
              ],
            )),
        Shared.getInstance().layout == 2
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BannerAdsCustom.getInstanceBottomAds(context),
                ],
              )
            : Container(
                color: Colors.black,
              )
      ],
    );
  }
}
