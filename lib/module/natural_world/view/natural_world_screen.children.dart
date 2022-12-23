part of 'natural_world_screen.dart';

extension NaturalWorldScreenChildren on NaturalWorldScreen {
  Widget itemImage(
      {required ResultDetect resultDetect,
      required BuildContext context,
      required Function(int index, bool nice) nice}) {
    bool like = resultDetect.isLike!;
    if (Shared.getInstance().favoriteCache != null) {
      Shared.getInstance().favoriteCache!.forEach((element) {
        if (element.title == resultDetect.title) {
          like = true;
          return;
        }
      });
    }

    return Container(
      margin: EdgeInsets.only(top: 8, left: 5),
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
                height: 125,
                width: Get.width / 2 - 10,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        resultDetect.thumbnail != null
                            ? resultDetect.thumbnail!.source!
                            : StringCommon.defaultImage,
                      ),
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
                child: Container(
                    padding: const EdgeInsets.all(3.0),
                    margin: const EdgeInsets.only(right: 10, top: 4),
                    child: FavoriteButton(
                        iconSize: 40,
                        isFavorite: like,
                        valueChanged: (value) {
                          if (value) {
                            nice(
                                controller.listItemResult.indexOf(resultDetect),
                                true);

                            Shared.getInstance()
                                .favoriteCache!
                                .add(resultDetect);
                            Shared.getInstance().saveFavorite(
                                cacheFavorite:
                                    Shared.getInstance().favoriteCache!);
                          } else {
                            nice(
                                controller.listItemResult.indexOf(resultDetect),
                                false);

                            Shared.getInstance()
                                .favoriteCache!
                                .remove(resultDetect);
                            Shared.getInstance().saveFavorite(
                                cacheFavorite:
                                    Shared.getInstance().favoriteCache!);
                          }
                        })),
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
    );
  }

  void _showContent(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          // title: new Text('You clicked on'),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  ResourceIcon.iconPlant,
                  color: AppColor.gray2,
                  width: 24,
                  height: 24,
                ),
                Image.asset(
                  ResourceIcon.iconPet,
                  color: AppColor.gray2,
                  width: 24,
                  height: 24,
                ),
                Image.asset(
                  ResourceIcon.iconMushroom,
                  color: AppColor.gray2,
                  width: 24,
                  height: 24,
                ),
                Image.asset(
                  ResourceIcon.iconBird,
                  color: AppColor.gray2,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
          actions: [
            new TextButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
