import 'dart:io';

import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class ToolBarCommon extends StatefulWidget {
  final Function() onclick;
  final Function()? onTapSearch;
  final String title;
  final Widget? trailing;
  bool? showPopButton;
  ToolBarCommon(
      {Key? key,
      required this.onclick,
      required this.title,
      this.trailing,
      this.onTapSearch,
      this.showPopButton})
      : super(key: key);

  @override
  _ToolBarCommonState createState() => _ToolBarCommonState();
}

class _ToolBarCommonState extends State<ToolBarCommon> {
  @override
  Widget build(BuildContext context) {
    //Scaffold(appBar: AppBar(actions: [],),);
    return Container(
      padding: EdgeInsets.only(top: DimensCommon.paddingTop(context: context)),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: DimensCommon.kPaddingToolbar,
            horizontal: DimensCommon.kPaddingToolbar),
        child: Row(
          children: [
            Visibility(
              visible: widget.showPopButton ?? true,
              child: InkWell(
                  onTap: () {
                    widget.onclick();
                  },
                  child: Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    size: 24,
                  )),
            ),
            SizedBox(
              width: 23,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextAppStyle().textToolBar(),
                ),
              ),
            ),
            InkWell(
              onTap: widget.onTapSearch,
              child: imageFromLocale(url: ResourceIcon.iconSearchAppBar),
            ),
            SizedBox(
              width: DimensCommon.kPaddingMedium,
            ),
          ],
        ),
      ),
    );
  }
}
