import 'package:base_flutter_framework/utils/color.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        widget.onLoading();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount,
                  childAspectRatio: widget.childAspectRatio),
              itemCount: widget.listFullData.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: () {
                    widget.onclickItem(position);
                  },
                  child: widget.itembuilder(context, position),
                );
              },
            ),
            Visibility(
                visible: widget.limit == false,
                child: const LoadMoreIndicator())
          ],
        ),
      ),
    );
  }
}
