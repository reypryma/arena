import 'package:flutter/material.dart';

class Language {
  int id;
  String name;
  String languageCode;

  Language(this.id, this.name, this.languageCode);

  static List<Language> getLanguages() {
    return <Language>[
      Language(0, 'English', 'en'),
      Language(1, 'Afrikaans', 'af'),
      Language(2, 'Arabic', 'ar'),
      Language(3, 'German', 'de'),
      Language(4, 'Spanish', 'es'),
      Language(5, 'French', 'fr'),
      Language(6, 'Hindi', 'hi'),
      Language(7, 'Indonesian', 'id'),
      Language(8, 'Japanese', 'ja'),
      Language(9, 'Dutch', 'nl'),
      Language(10, 'Portuguese', 'pt'),
      Language(11, 'Turkish', 'tr'),
      Language(12, 'Italian', 'it'),
      Language(13, 'Korean', 'ko'),
      Language(14, 'Nepali', 'ne'),
      Language(15, 'Russian', 'ru'),
      Language(16, 'Vietnamese', 'vi'),
      Language(17, 'Hebrew', 'he'),
      Language(18, 'Thai', 'th'),
    ];
  }

  static List<String> languages() {
    List<String> list = [];

    getLanguages().forEach((element) {
      list.add(element.languageCode);
    });

    return list;
  }

  static List<Locale> languagesLocale() {
    List<Locale> list = [];

    getLanguages().forEach((element) {
      list.add(Locale(element.languageCode, ''));
    });

    return list;
  }
}
