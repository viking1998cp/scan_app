import 'package:base_flutter_framework/components/widget/favorite_button.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/icons/app_icons.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:flutter/material.dart';

class ItemCache extends StatefulWidget {
  final ResultDetect resultDetect;

  //mode==1 collecttion
  //mode==2 favorite
  final int mode;
  Function()? unLikeClick;
  Function()? remoClick;
  ItemCache(
      {Key? key,
      required this.resultDetect,
      required this.mode,
      this.unLikeClick,
      this.remoClick})
      : super(key: key);

  @override
  _ItemCacheState createState() => _ItemCacheState();
}

class _ItemCacheState extends State<ItemCache> {
  Widget itemImage({required ResultDetect resultDetect}) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 5, bottom: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(1, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 127,
                  width: DimensCommon.sizeWidth(context: context) / 2 - 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(resultDetect.thumbnail != null
                            ? resultDetect.thumbnail!.source!
                            : StringCommon.defaultImage),
                        fit: BoxFit.cover),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: SizedBox(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 96),
                  height: 30,
                  color: Color(0x80FFFFFF),
                  child: Center(
                      child: Text(
                    '${resultDetect.title}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: widget.mode == 2
                          ? FavoriteButton(
                              isFavorite: true,
                              iconSize: 30,
                              valueChanged: (value) {
                                widget.unLikeClick!();
                              })
                          : IconButton(
                              onPressed: () {
                                widget.remoClick!();
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.grey[800],
                              ))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                '${resultDetect.extract}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return itemImage(resultDetect: widget.resultDetect);
  }
}
