import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/resource/resource_image.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:flutter/material.dart';

class DialogBuypro extends StatefulWidget {
  const DialogBuypro({Key? key}) : super(key: key);

  @override
  _DialogBuyproState createState() => _DialogBuyproState();
}

class _DialogBuyproState extends State<DialogBuypro> {
  Widget itemInfoBuyPro(
      {required String title,
      required String content,
      required String urlIcon,
      required Color titleColor}) {
    return Row(
      children: [
        Container(
            width: 60,
            alignment: Alignment.center,
            child: imageFromLocale(url: urlIcon, width: 24, height: 24)),
        Expanded(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, color: titleColor),
                  )),
              SizedBox(
                height: 6,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget itemButtonBuyPro(
      {required String title, required Function() onClick}) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(8)),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buttonBuyPro() {
    return Row(
      children: [
        Expanded(
            child: itemButtonBuyPro(
                title: TransactionKey.loadLanguage(
                    context, TransactionKey.oneYear),
                onClick: () {})),
        SizedBox(
          width: 8,
        ),
        Expanded(
            child: itemButtonBuyPro(
                title: TransactionKey.loadLanguage(
                    context, TransactionKey.oneMonth),
                onClick: () {})),
        SizedBox(
          width: 8,
        ),
        Expanded(
            child: itemButtonBuyPro(
                title: TransactionKey.loadLanguage(
                    context, TransactionKey.tryFree),
                onClick: () {})),
      ],
    );
  }

  Widget footerBuyPro() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text(
          TransactionKey.loadLanguage(context, TransactionKey.tryFreeDetail),
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          TransactionKey.loadLanguage(context, TransactionKey.recurringBilling),
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  TransactionKey.loadLanguage(
                      context, TransactionKey.titleBuyPro),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              itemInfoBuyPro(
                  content: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro1Content),
                  title: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro1Title),
                  urlIcon: ResourceImage.imageBuyProSheild,
                  titleColor: ColorCommon.colorTitleBuyPro1),
              SizedBox(
                height: 32,
              ),
              itemInfoBuyPro(
                  content: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro2Content),
                  title: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro2Title),
                  urlIcon: ResourceImage.imageBuyProStar,
                  titleColor: Colors.orange),
              SizedBox(
                height: 32,
              ),
              itemInfoBuyPro(
                  content: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro3Content),
                  title: TransactionKey.loadLanguage(
                      context, TransactionKey.buyPro3Title),
                  urlIcon: ResourceImage.imgBuyProHeart,
                  titleColor: Colors.red),
              SizedBox(
                height: 32,
              ),
              buttonBuyPro(),
              footerBuyPro()
            ],
          ),
        ),
      ),
    );
  }
}
