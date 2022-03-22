import 'package:base_flutter_framework/services/service.dart';
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

  static Future<List<String>> naturalHtml(String body, type) async{
    Set<String> name = Set();
    final document = parse(body, generateSpans: true);

    List data = [];
    switch(type){
      case 0:
        data = document.querySelectorAll("div#bodyContent").first.querySelectorAll("div.div-col>ul").first.querySelectorAll("li>a");
        break;
      case 1:
        data = document.querySelectorAll("div.div-col").first.querySelectorAll("li>a");
        break;
      case 2:
        List tmp = [];
        document.querySelectorAll("div.mw-category-group").forEach((element) {
          element.querySelectorAll("li>a").forEach((e) {
            tmp.add("https://en.wikipedia.org" + e.attributes["href"]!);
          });
        });
        (await Future.wait(tmp.map((e) => ServiceCommon.getInstance()!.getHttp(api: e, host: "")))).map((response) {
          try {
            return parse(response!.data, generateSpans: true)
                .querySelectorAll("div.mw-parser-output>ul")
                .first
                .querySelectorAll("li>a");
          } catch (e) {
            return [];
          }
        }).toList().forEach((element) {
          data.addAll(element);
        });
        break;
      case 3:
        data = document.querySelectorAll("li>a");
        break;
    }
    data.forEach((element) {
      if(element.attributes['title'] != null && element.attributes['href'] != null && !element.attributes['title']!.contains("page does not exist") && element.attributes['href']!.startsWith("/")){
        name.add(element.attributes['title']!);
      }
    });
    List<String> result = name.toList();
    result.shuffle();
    if (result.length > 50) {
      return result.sublist(0, 49);
    }
    return result;
  }


  static double fontSizeScaleFlowLeght(String name,
      {required double leghtScale, required double fontDefault}) {
    return fontDefault - ((name.length / leghtScale) * 2);
  }
}
