import 'package:html/parser.dart';

class StringCommon {
  static String keyColor = "COLOR BOX";
  static String keyTimeFree = "TIME_FREE";
  static String keyBuyFree = "BUY_FREE";
  static String keyLayOut = "LAYOUT";
  static String keyDeviceId = "DEVICE_ID";
  static String keyFavorite = "FAVORITE";
  static String keyCollection = "COLLECTION";
  static String key = "DEVICE_ID";

  static String codeLanguage = "LANGUAGE";
  static String defaultImage =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.png";
  static String formatHtml(String html) {
    final document = parse(html, generateSpans: true);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  static String maxString(Iterable<String> listString) {
    String maxString = '';
    listString.forEach((element) {
      if (element.length > maxString.length) {
        maxString = element;
      }
    });
    return maxString;
  }

  static double fontSizeScaleFlowLeght(String name,
      {required double leghtScale, required double fontDefault}) {
    return fontDefault - ((name.length / leghtScale) * 2);
  }
}
