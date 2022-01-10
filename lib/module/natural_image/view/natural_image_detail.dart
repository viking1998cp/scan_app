import 'dart:math';

import 'package:base_flutter_framework/module/natural_image/controller/natural_image_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageDetailScreen extends GetView<NaturalImageController> {
  final indexPage;
  const ImageDetailScreen({Key? key, required this.indexPage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: () {
                controller.bottomMenu.value = true;
                controller.autoPlay.value = false;
              },
              child: controller.downloading.value
                  ? imageDownloadDialog()
                  : CarouselSlider.builder(
                      itemCount: controller.wallpaperIds.length,
                      itemBuilder: (ctx, index, idx) {
                        var id = controller.wallpaperIds[index];
                        return Stack(
                          children: [
                            Obx(() {
                              return Transform.rotate(
                                  angle: controller.degrees.value * pi / 180,
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    // decoration: ImageD,
                                    child: CachedNetworkImage(
                                      imageUrl: getImageRonate(id.id),
                                      placeholder: (context, url) {
                                        return Center(
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator()),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Icon(Icons.error);
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            }),
                            controller.bottomMenu.value == true
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      width: double.infinity,
                                      height: 40,
                                      // color: Color.fromARGB(60, 158, 158, 158),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ))),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    controller.degrees.value =
                                                        controller.degrees.value + 90;
                                                    if (controller.degrees.value ==
                                                        360) {
                                                      controller.degrees.value = 0;
                                                      controller.setDegrees.value =
                                                          true;
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.refresh,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                                controller.autoPlay.value == true
                                                    ? InkWell(
                                                        onTap: () {
                                                          controller.autoPlay.value =
                                                              false;
                                                        },
                                                        child: Icon(
                                                          Icons.pause,
                                                          color: Colors.white,
                                                          size: 24,
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          controller.autoPlay.value =
                                                              true;
                                                          controller.bottomMenu
                                                              .value = false;
                                                        },
                                                        child: Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.white,
                                                          size: 24,
                                                        ),
                                                      ),
                                                InkWell(
                                                    onTap: () async {
                                                      await downloadImage(
                                                          context, "${id.id}");
                                                    },
                                                    child: Icon(
                                                      Icons.image_outlined,
                                                      color: Colors.white,
                                                      size: 24,
                                                    )),
                                                InkWell(
                                                  onTap: () async {
                                                    controller.downloadImageStatus
                                                        .value = true;
                                                    try {
                                                      if (controller
                                                              .downloadImageStatus
                                                              .value ==
                                                          true) {
                                                        downloadDialog(context);
                                                      }
                                                      // Saved with this method.
                                                      var imageId =
                                                          await ImageDownloader
                                                              .downloadImage(
                                                                  getImageRonate(
                                                                      id.id));
                                                      if (imageId != null) {
                                                        Navigator.pop(context);
                                                      }
                                                      if (imageId == null) {
                                                        return;
                                                      }
                                                      Get.snackbar('Successful',
                                                          'Download successfully!',
                                                          snackPosition:
                                                              SnackPosition.BOTTOM);
                                                    } on PlatformException catch (error) {
                                                      print(error);
                                                      Get.snackbar('Failed',
                                                          'Download failed!',
                                                          snackPosition:
                                                              SnackPosition.BOTTOM);
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.file_download,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1,
                        initialPage: indexPage,
                        autoPlay: controller.autoPlay.value,
                      )),
            ),
          ),
        ),
      );
    });
  }

  Future<void> downloadImage(BuildContext context, String id) async {
    controller.progressString =
        Wallpaper.imageDownloadProgress(getImageRonate(id));
    controller.progressString!.listen((data) {
      controller.res!.value = data;
      controller.downloading.value = true;
      print("DataReceived: " + data);
    }, onDone: () async {
      controller.downloading.value = false;
      controller.isDisable.value = false;
      _showDialogSetWallpaper(context);
    }, onError: (error) {
      controller.downloading.value = false;
      controller.isDisable.value = true;
    });
  }

  Widget imageDownloadDialog() {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              "Downloading File : ${controller.res}",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void downloadDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20.0),
                Text(
                  "Downloading ...",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialogSetWallpaper(BuildContext context) {
    String home = "Home Screen",
        lock = "Lock Screen",
        both = "Both Screen",
        system = "System";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return AlertDialog(
            content: Container(
              height: 70,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          controller.isDisable.value
                              ? null
                              : home = await Wallpaper.homeScreen(
                                  options: RequestSizeOptions.RESIZE_FIT,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height);
                          controller.downloading.value = false;
                          home = home;
                          Get.snackbar(
                              'Home Screen', 'Set wallpaper successfully!',
                              snackPosition: SnackPosition.BOTTOM);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.home_outlined,
                          color: Colors.blue,
                          size: 36,
                        ),
                      ),
                      Text('Home Screen')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: controller.isDisable.value
                            ? null
                            : () async {
                                both = await Wallpaper.bothScreen();
                                controller.downloading.value = false;
                                both = both;
                                Get.snackbar('Both Screen',
                                    'Set wallpaper successfully!',
                                    snackPosition: SnackPosition.BOTTOM);
                                Navigator.of(context).pop();
                              },
                        icon: Icon(
                          Icons.image,
                          color: Colors.blue,
                          size: 36,
                        ),
                      ),
                      Text('Both Screen')
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: controller.isDisable.value
                            ? null
                            : () async {
                                lock = await Wallpaper.lockScreen();
                                controller.downloading.value = false;
                                lock = lock;
                                Get.snackbar('Lock Screen',
                                    'Set wallpaper successfully!',
                                    snackPosition: SnackPosition.BOTTOM);
                                Navigator.of(context).pop();
                              },
                        icon: Icon(
                          Icons.lock_outlined,
                          color: Colors.blue,
                          size: 36,
                        ),
                      ),
                      Text('Lock Screen')
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  String getImageRonate(String id) {
    if (controller.degrees.value == 90 || controller.degrees.value == 240) {
      return "http://i.7fon.org/800/$id.jpg";
    } else {
      return "http://i.7fon.org/thumb/$id.jpg";
    }
  }
}
