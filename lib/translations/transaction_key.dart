import 'package:base_flutter_framework/translations/app_translations.dart';
import 'package:flutter/material.dart';

class TransactionKey {
  static final String keyHome = 'home';
  static final String scan = 'scan';
  static final String scanImage = 'scan image';
  static final String naturalWorld = 'natural world';
  static final String naturalToday = 'natural today';
  static final String myID = 'My ID';
  static final String historyFavorite = 'history favorite';
  static final String favorite = 'Favorite';
  static final String search = 'search';
  static final String searchObject = 'search object';
  static final String naturalImage = 'natural image';
  static final String beautyImageOfWorld = 'beauty image of world';
  static final String match = 'match';

  static final String trending = 'Trending';
  static final String subTrending = 'Trending data';
  static final String myBirds = 'My birds';
  static final String subMyBirds = 'Your collection, favor...';
  static final String wallpaper = 'Wallpaper';
  static final String subWallpaper = 'Set your wallpaper';

  static final String setting = 'setting';
  static final String changeLayout = 'change layout';
  static final String changeTheme = 'Change Theme';
  static final String bottomMenu = 'bottom menu';
  static final String language = 'Change language';
  static final String feedback = 'Feedback';
  static final String buyPro = 'Buy pro';
  static final String share = 'Share';
  static final String rateUs = 'Rate us';
  static final String moreApp = 'more app';
  static final String selectLayout = "select layout";
  static final String selectCancel = "cancel";
  static final String selectOk = "ok";
  static final String takePhoto = "Take photo";
  static final String collection = "Collection";

  static final String name = "name";
  static final String inputMatchName = "Input name Match";
  static final String matchSave = "Search results will be save";

  //detect language
  static final String picture = 'picture';
  static final String notFound = 'Not found';
  static final String more = 'more';
  static final String cropper = "Cropper";
  static final String loadingData = "Loading data";

  static String loadLanguage(BuildContext context, String key) {
    return AppTranslations.of(context).text(key);
  }
}
