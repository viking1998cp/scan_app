import 'package:base_flutter_framework/translations/app_translations.dart';
import 'package:flutter/material.dart';

class TransactionKey {
  static final String keyHome = 'home';
  static final String scan = 'scan';
  static final String scanImage = 'scan_image';
  static final String naturalWorld = 'natural_world';
  static final String naturalToday = 'natural_today';
  static final String myID = 'my_id';
  static final String historyFavorite = 'history_favorite';
  static final String favorite = 'favorite';
  static final String search = 'search';
  static final String searchObject = 'search_object';
  static final String naturalImage = 'natural_image';
  static final String beautyImageOfWorld = 'beauty_image_of_world';
  static final String match = 'match';

  static final String trending = 'trending';
  static final String subTrending = 'trending_data';
  static final String myBirds = 'my_birds';
  static final String subMyBirds = 'your_collection_favor';
  static final String wallpaper = 'wallpaper';
  static final String subWallpaper = 'set_your_wallpaper';

  static final String setting = 'setting';
  static final String changeLayout = 'change_layout';
  static final String changeTheme = 'change_theme';
  static final String bottomMenu = 'bottom_menu';
  static final String language = 'change_language';
  static final String feedback = 'feedback';
  static final String buyPro = 'buy_pro';
  static final String share = 'share';
  static final String rateUs = 'rate_us';
  static final String moreApp = 'more_app';
  static final String selectLayout = "select_layout";
  static final String selectCancel = "cancel";
  static final String selectOk = "ok";
  static final String notification = "notification";
  static final String takePhoto = "take_photo";
  static final String collection = "collection";
  static final String titleCloseApp = "title_close_app";

  static final String selectLanguage = "select_language";

  static final String name = "name";
  static final String inputMatchName = "input_name_match";
  static final String matchSave = "search_results_will_be_save";

  static final String rateYourExperience = "rate_your_experience";

  static final String titleRate = "title_rate";
  static final String thankRatting = "thank_ratting";
  static final String rateInStore = "rate_in_store";

  //detect language
  static final String picture = 'picture';
  static final String notFound = 'not_found';
  static final String more = 'more';
  static final String cropper = "cropper";
  static final String loadingData = "loading_data";

  static final String score = "score";

  static String loadLanguage(BuildContext context, String key) {
    return AppTranslations.of(context).text(key);
  }
}
