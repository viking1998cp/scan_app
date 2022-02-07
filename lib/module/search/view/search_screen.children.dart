part of 'search_screen.dart';

extension SearchScreenChildren on SearchScreen {
  Widget itemSearch(
      ResultDetect resultDetect, Function(int index, bool nice) nice) {
    bool like = resultDetect.isLike!;
    if (Shared.getInstance().favoriteCache != null) {
      Shared.getInstance().favoriteCache!.forEach((element) {
        if (element.title == resultDetect.title) {
          like = true;
          return;
        }
      });
    }
    print(resultDetect.extractHtml!);
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(resultDetect.thumbnail != null
                            ? resultDetect.thumbnail!.source!
                            : StringCommon.defaultImage))),
                child: SizedBox(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        StringCommon.formatHtml(resultDetect.displaytitle!),
                        style: TextAppStyle().textBlackBoldStyle(),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Html(
                      data: resultDetect.extractHtml!
                          .replaceAll("<li>", "")
                          .replaceAll("</li>", "")
                          .replaceAll("<p>", "")
                          .replaceAll("</p>", "")
                          .replaceAll("<ul>", "")
                          .replaceAll("</ul>", ""),
                      style: {
                        'body': Style(
                          fontSize: FontSize(12),
                          maxLines: 2,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      },
                    ),
                  ],
                ),
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
                            nice(controller.dataSearch.indexOf(resultDetect),
                                true);

                            Shared.getInstance()
                                .favoriteCache!
                                .add(resultDetect);
                            Shared.getInstance().saveFavorite(
                                cacheFavorite:
                                    Shared.getInstance().favoriteCache!);
                          } else {
                            nice(controller.dataSearch.indexOf(resultDetect),
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
        ),
      ),
    );
  }

  Widget emptyData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25,
        ),
        Container(height: 300, child: BannerAdsCustom.getInstanceBigAds())
      ],
    );
  }
}
