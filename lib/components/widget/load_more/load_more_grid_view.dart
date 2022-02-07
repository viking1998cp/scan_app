import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'load_more_indicator.dart';

class LoadMoreGridView extends StatefulWidget {
  final bool loading;
  final bool limit;
  final List<dynamic> listFullData;
  final Function() onLoading;
  final Widget Function(BuildContext context, int index) itembuilder;
  final Function(int index) onclickItem;
  final double childAspectRatio;
  final int crossAxisCount;
  const LoadMoreGridView(
      {Key? key,
      required this.listFullData,
      required this.onLoading,
      required this.loading,
      required this.itembuilder,
      required this.onclickItem,
      required this.limit,
      required this.childAspectRatio,
      required this.crossAxisCount})
      : super(key: key);

  @override
  _LoadMoreGridViewState createState() => _LoadMoreGridViewState();
}

class _LoadMoreGridViewState extends State<LoadMoreGridView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        widget.onLoading();
      },
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 8),
          child: Column(
            children: [
              SingleChildScrollView(
                  child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(widget.listFullData.length, (index) {
                  index++;
                  if (index % 11 == 0) {
                    return BannerAdsCustom.getInstanceSmallAds(context);
                  }

                  return InkWell(
                    onTap: () {
                      widget.onclickItem(index - 1);
                    },
                    child: Container(
                        width:
                            (DimensCommon.sizeWidth(context: context) / 2) - 10,
                        child: widget.itembuilder(context, index - 1)),
                  );
                }),
              )),
              Visibility(
                  visible: widget.limit == false,
                  child: const LoadMoreIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
