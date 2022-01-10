import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';

class ItemMenu extends StatefulWidget {
  final String icon;
  final String title;
  final String? subTitle;
  final Function() onclick;
  const ItemMenu(
      {Key? key,
      required this.icon,
      required this.onclick,
      this.subTitle,
      required this.title})
      : super(key: key);

  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onclick();
      },
      child: Card(
        child: Container(
          // decoration: ContainerAppStyle().boderItemMenu(),

          padding: EdgeInsets.symmetric(
              vertical: DimensCommon.kPaddingVeryMin,
              horizontal: DimensCommon.kPaddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              imageFromLocale(
                  url: widget.icon,
                  width: 20,
                  height: 20,
                  color: Theme.of(context).primaryColor),
              SizedBox(
                width: DimensCommon.kPaddingMax,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextAppStyle().styleContent(),
                      ),
                    ),
                    Visibility(
                      visible: widget.subTitle != null,
                      child: Container(
                        margin: EdgeInsets.only(top: 4),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.subTitle ?? "",
                          style: TextAppStyle().styleSubContent(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
