import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  List<String> languageCode = ['en', 'ar', 'de', 'es', 'fa', 'fr', 'hi', 'id', 'it', 'ja', 'ko', 'my', 'pt', 'ru', 'th', 'tr', 'zh'];
  String langCode = "";

  setLanguage(String languageCode) {
    langCode = languageCode;
    notifyListeners();
  }
}
