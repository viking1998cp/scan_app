import 'dart:async';

import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/components/widget/dialog/buy_pro.dart';
import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/app_translations.dart';
import 'package:base_flutter_framework/translations/application.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/navigator.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List<String> language = [];
  String select = "";
  int indexSelect = 0;
  @override
  void initState() {
    super.initState();
    language.add("Automatic*");
    Application().supportedLanguagesName.forEach((element) {
      String localeName = Application().supportedLanguagesCodes[
          Application().supportedLanguagesName.indexOf(element)];
      if (localeName == Shared.getInstance().localeCode && select == "") {
        select = element;
        indexSelect = Application().supportedLanguagesName.indexOf(element);
      }
      language.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: DimensCommon.sizeHeight(context: context) - 100,
          padding: EdgeInsets.symmetric(vertical: 16),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: InkWell(
                    child: Text(
                        TransactionKey.loadLanguage(
                            context, TransactionKey.selectLanguage),
                        style: TextAppStyle().textTitleStyle())),
              ),
              SizedBox(
                height: 12,
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: language.isEmpty
                      ? indicator()
                      : RadioGroup<String>.builder(
                    
                          groupValue: select,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) async {
                            indexSelect = Application()
                                .supportedLanguagesName
                                .indexOf(value!);

                            select = value;
                            setState(() {});
                          },
                          textStyle: TextStyle(fontSize: 16),
                          items: language,
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                          ),
                        ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                          style: TextAppStyle()
                              .styleTextScore(context)
                              .copyWith(color: hexToColor("#00DDC2")),
                        )),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                        onTap: () async {
                          if (Application()
                                  .supportedLanguagesName[indexSelect]
                                  .contains('*') &&
                              Shared.getInstance().buyFree == false) {
                            await showBottomSheet(
                                context: context, child: DialogBuypro());
                            return;
                          }
                          if (indexSelect == -1) {
                            await Shared.getInstance()
                                .saveLocaleCodeAutomatic();
                          } else {
                            await Shared.getInstance().saveLocaleCode(
                                code: Application()
                                    .supportedLanguagesCodes[indexSelect]);
                          }

                          Get.toNamed(Routes.SPLASH);
                        },
                        child: Text(
                          TransactionKey.loadLanguage(
                              context, TransactionKey.selectOk),
                          style: TextAppStyle()
                              .styleTextScore(context)
                              .copyWith(color: hexToColor("#00DDC2")),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet(
      {required Widget child, required BuildContext context}) async {
    await showModalBottomSheet<dynamic>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [child],
          );
        });
  }
}
