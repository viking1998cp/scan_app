import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/resource/resource_image.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';

import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogChangeLayout extends StatefulWidget {
  const DialogChangeLayout({Key? key}) : super(key: key);

  @override
  _DialogChangeLayoutState createState() => _DialogChangeLayoutState();
}

class _DialogChangeLayoutState extends State<DialogChangeLayout> {
  int selectLayout = 1;
  @override
  initState() {
    selectLayout = Shared.getInstance().layout!;
    super.initState();
  }

  Widget itemLayout(
      {required String image,
      required Function() onClick,
      required int index}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
        decoration: index == selectLayout
            ? BoxDecoration(border: Border.all(color: Colors.black, width: 1))
            : null,
        child: imageFromLocale(url: image, width: 50, height: 50),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: EdgeInsets.all(5),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 11),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TransactionKey.loadLanguage(
                          context, TransactionKey.selectLayout),
                      style: TextAppStyle().textTitleStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      itemLayout(
                          image: ResourceImage.imageLayOutBottom,
                          onClick: () async {
                            selectLayout = 1;

                            setState(() {});
                          },
                          index: 1),
                      itemLayout(
                          image: ResourceImage.imageLayOutScreen,
                          onClick: () async {
                            selectLayout = 2;

                            setState(() {});
                          },
                          index: 2),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            TransactionKey.loadLanguage(
                                context, TransactionKey.selectCancel),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: hexToColor("#00DDC2")),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        InkWell(
                          onTap: () async {
                            await Shared.getInstance()
                                .saveLayOutScreen(layout: selectLayout);

                            Get.offAllNamed(Routes.SPLASH);
                          },
                          child: Text(
                            TransactionKey.loadLanguage(
                                context, TransactionKey.selectOk),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: hexToColor("#00DDC2")),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
