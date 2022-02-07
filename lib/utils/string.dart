import 'package:html/parser.dart';

class StringCommon {
  static String keyColor = "COLOR BOX";
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

  static List<String> naturalHtml(String body) {
    List<String> html = body.split("<li>");
    List<String> name = [];
    for (var i = 1; i < html.length; i++) {
      int index = html[i].indexOf("</a>", 0);
      String data1 = html[i].substring(0, index + 4);
      String data = StringCommon.formatHtml(data1);
      name.add(data);
    }

    List<String> nameFormatIssue = [];
    name.forEach((element) {
      if (element.length != 1) {
        nameFormatIssue.add(element);
      }
    });
    if (nameFormatIssue.length > 50) {
      return nameFormatIssue.sublist(0, 49);
    }
    return nameFormatIssue;
  }

  static double fontSizeScaleFlowLeght(String name,
      {required double leghtScale, required double fontDefault}) {
    return fontDefault - ((name.length / leghtScale) * 2);
  }
}
