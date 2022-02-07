import 'dart:ui';

class Application {
  static final Application _application = Application._internal();

  factory Application() {
    return _application;
  }

  Application._internal();

  final List<String> supportedLanguagesCodes = [
    "en",
    "vi",
    "af",
    "ar",
    "az",
    "be",
    "bg",
    "bn",
    "ca",
    "cs",
    "da",
    "de",
    "el",
    "es",
    "et",
    "eu",
    "fa",
    "fi",
    "fr",
    "hi",
    "hr",
    "hu",
    "hy",
    "in",
    "is",
    "it",
    "iw",
    "ja",
    "km",
    "kn",
    "ko",
    "lo",
    "lt",
    "lv",
    "mk",
    "ml",
    "mn",
    "mr",
    "ms",
    "my",
    "nb",
    "ne",
    "nl",
    "pt",
    "ro",
    "ru",
    "si",
    "sk",
    "sl",
    "sr",
    "sv",
    "sw",
    "te",
    "th",
    "tr",
    "uk",
    "zh",
    "zh-rCN",
    "zh-rTW",
    "zu"
  ];

  final List<String> supportedLanguagesName = [
    "English",
    "Tiếng Việt",
    "Afrikaans",
    "العربية",
    "Azərbaycan",
    "Беларуская",
    "Български",
    "বাংলা",
    "Català",
    "Čeština",
    "Dansk",
    "Deutsch",
    "Ελληνικά",
    "Español",
    "Eesti",
    "Euskara",
    "فارسی",
    "Suomi",
    "Français",
    "हिन्दी",
    "Hrvatski",
    "Magyar"
        "Հայերեն",
    "Indonesia",
    "Íslenska",
    "Italiano",
    "עברית",
    "日本語",
    "ខ្មែរ",
    "ಕನ್ನಡ",
    "한국어",
    "ລາວ",
    "Lietuvių",
    "Latviešu",
    "Македонски",
    "മലയാളം",
    "Монгол",
    "मराठी",
    "Melayu",
    "မြန်မာ",
    "Norsk Bokmål",
    "नेपाली",
    "Nederlands",
    "Português",
    "Română",
    "Русский",
    "සිංහල",
    "Slovenčina",
    "Slovenščina",
    "Српски",
    "Svenska",
    "Kiswahili",
    "తెలుగు",
    "ไทย",
    "Türkçe",
    "Українська",
    "中文",
    "中文 (rcn)",
    "中文 (rtw)",
    "Isizulu"
  ];

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));

  //function to be invoked when changing the language
  LocaleChangeCallback? onLocaleChanged;
}

Application application = Application();

typedef void LocaleChangeCallback(Locale locale);
