import 'dart:async';
import 'dart:io';

import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/resource/resource_image.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/sk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class DialogBuypro extends StatefulWidget {
  const DialogBuypro({Key? key}) : super(key: key);

  @override
  _DialogBuyproState createState() => _DialogBuyproState();
}

class _DialogBuyproState extends State<DialogBuypro> {
  final Set<String> _productLists = Platform.isAndroid
      ? <String>{
          'subs_after_try',
          'subs_vip_month',
          'subs_vip_year',
        }
      : <String>{
          "subs_after_try",
          'subs_vip_month',
          'subs_vip_year',
        };

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _inAppPurchase.isAvailable();
  }

  @override
  void initState() {
    initPlatformState();
    getProductRepository(kIds: _productLists);

    super.initState();
  }

  ProductDetailsResponse? response;
  List<ProductDetails> products = [];
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  Future<List<ProductDetails>> getProductRepository(
      {required Set<String> kIds}) async {
    try {
      response = await InAppPurchase.instance.queryProductDetails(kIds);

      setState(() {
        products = response!.productDetails;
      });
      return products;
    } catch (_e) {
      return [];
    }
  }

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
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.orange, borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget buttonBuyPro() {
    return products.isEmpty
        ? indicator()
        : Row(
            children: [
              Expanded(
                  child: itemButtonBuyPro(
                      title: TransactionKey.loadLanguage(
                          context, TransactionKey.oneYear),
                      onClick: () async {
                        PurchaseParam purchaseParam = PurchaseParam(
                          productDetails: products[2],
                        );

                        await _inAppPurchase
                            .buyNonConsumable(purchaseParam: purchaseParam)
                            .then((value) {
                          if (value = true) {
                            Shared.instance!.saveBuy(buy: true);
                            int timeBuy =
                                (((DateTime.now().millisecondsSinceEpoch) /
                                            1000) +
                                        31536000)
                                    .round();

                            SKToast.success(
                                title: TransactionKey.loadLanguage(
                                        context, TransactionKey.notification)
                                    .toUpperCase(),
                                message: TransactionKey.loadLanguage(
                                        context, TransactionKey.successBuyPro) +
                                    fromTimeHourToString(timeBuy),
                                context: context);
                          }
                        });
                      })),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: itemButtonBuyPro(
                      title: TransactionKey.loadLanguage(
                          context, TransactionKey.oneMonth),
                      onClick: () async {
                        PurchaseParam purchaseParam = PurchaseParam(
                          productDetails: products[1],
                        );

                        await _inAppPurchase
                            .buyNonConsumable(purchaseParam: purchaseParam)
                            .then((value) {
                          if (value = true) {
                            Shared.instance!.saveBuy(buy: true);
                            int timeBuy =
                                (((DateTime.now().millisecondsSinceEpoch) /
                                            1000) +
                                        2592000)
                                    .round();
                            if (Platform.isAndroid) {
                              SKToast.success(
                                  title: TransactionKey.loadLanguage(
                                          context, TransactionKey.notification)
                                      .toUpperCase(),
                                  message: TransactionKey.loadLanguage(context,
                                          TransactionKey.successBuyPro) +
                                      fromTimeHourToString(timeBuy),
                                  context: context);
                            }
                          }
                        });
                      })),
              SizedBox(
                width: 8,
              ),
              Expanded(
                  child: itemButtonBuyPro(
                      title: TransactionKey.loadLanguage(
                          context, TransactionKey.tryFree),
                      onClick: () async {
                        PurchaseParam purchaseParam = PurchaseParam(
                          productDetails: products[0],
                        );

                        await _inAppPurchase
                            .buyNonConsumable(purchaseParam: purchaseParam)
                            .then((value) {
                          Shared.instance!.saveBuy(buy: true);
                          int timeBuy =
                              (((DateTime.now().millisecondsSinceEpoch) /
                                          1000) +
                                      259200)
                                  .round();

                          SKToast.success(
                              title: TransactionKey.loadLanguage(
                                      context, TransactionKey.notification)
                                  .toUpperCase(),
                              message: TransactionKey.loadLanguage(
                                      context, TransactionKey.successBuyPro) +
                                  fromTimeHourToString(timeBuy),
                              context: context);
                        });
                      })),
            ],
          );
  }

  String dateTimeToString7(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  String fromTimeHourToString(int? timestamp) {
    if (timestamp != null) {
      return dateTimeToString7(fromTimeStamp(timestamp * 1000));
    }
    return "";
  }

  DateTime fromTimeStamp(int timestamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timestamp);
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
