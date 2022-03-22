import 'package:async/async.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:html/parser.dart';

class NaturalRepository {
  int currentCount = 0;
  int skip = 0;

  Stream<List<String>> getNameNatural() {
   return StreamZip([
      ServiceCommon.getInstance()!
          .getHttp( api: 'https://en.wikipedia.org/wiki/List_of_dog_breeds', host: "")
          .asStream()
          .map((event) {
        return parse(event!.data, generateSpans: true).querySelectorAll("div#bodyContent")
            .first
            .querySelectorAll("div.div-col>ul")
            .first
            .querySelectorAll("li>a");
      }),
      ServiceCommon.getInstance()!
          .getHttp( api: 'https://en.wikipedia.org/wiki/List_of_birds_by_common_name', host: "")
          .asStream()
          .map((event) {
        return parse(event!.data, generateSpans: true)
            .querySelectorAll("div.div-col")
            .first
            .querySelectorAll("li>a");
      }),
      ServiceCommon.getInstance()!
          .getHttp( api:'https://en.wikipedia.org/wiki/Category:Lists_of_fungal_species',host: "")
          .asStream()
          .map((event) {
            List<String> urls = [];
              parse(event!.data, generateSpans: true).querySelectorAll(
                  "div.mw-category-group").forEach((element) {
                element.querySelectorAll("li>a").forEach((e) {
                  urls.add("https://en.wikipedia.org" + e.attributes["href"]!);
                });
              });
            return urls;
          })
          .asyncExpand((element) => Stream.fromIterable(element))
          .asyncExpand((event) {
            return ServiceCommon.getInstance()!
                .getHttp(api: event, host: "")
                .asStream()
                .map((event) {
              return parse(event!.data, generateSpans: true)
                  .querySelectorAll("div.mw-parser-output>ul")
                  .first
                  .querySelectorAll("li>i");
            });
          }),
      ServiceCommon.getInstance()!
          .getHttp(api:'https://en.wikipedia.org/wiki/List_of_plants_by_common_name', host: "")
          .asStream()
          .map((event) {
        return parse(event!.data, generateSpans: true).querySelectorAll("li>a");
      })
    ]).map((data) {
      Set<String> name = Set();
      data.forEach((elements) {
        elements.forEach((element) {
          if (element.attributes['title'] != null && element.attributes['href'] != null &&  !element.attributes['title']!.contains("page does not exist") && element.attributes['href']!.startsWith("/")) {
            name.add(element.attributes['title']!);
          }
        });
      });
      List<String> result = name.toList();
      result.shuffle();
      if (result.length > 200) {
        return result.sublist(0, 199);
      }
      return result;
    });
  }
}
