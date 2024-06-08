
import 'package:flutter/cupertino.dart';

class AppTranslationConstants {

  static final List<String> supportedLanguages = ['english', 'spanish', 'french', 'deutsch'];

  static const Map<String, Locale> supportedLocales = {
    'english': Locale('en', 'US'),
    'spanish': Locale('es', 'MX'),
    'french': Locale('fr', 'FR'),
    'deutsch': Locale('de', 'DE')
  };

  static const String es = 'es';

  static String languageFromLocale(Locale locale) {
    String language = "";
    switch(locale.languageCode){
      case 'en':
        language = "english";
        break;
      case 'esp':
        language = "spanish";
        break;
      case 'es':
        language = "spanish";
        break;
      case 'fr':
        language = "french";
        break;
      case 'de':
        language = "deutsch";
        break;
    }

    return language;
  }

  static const String close = "close";
  static const String minutes = "minutes";
  static const String seconds = "seconds";

  static const String shareComment = 'shareComment';
  static const String shareCommentMsg = 'shareCommentMsg';

  static const String createPost = 'createPost';
  static const String createPostMsg = 'createPostMsg';

  static const String organizeEvent = 'organizeEvent';
  static const String organizeEventMsg = 'organizeEventMsg';

  static const String version = 'Version';
  static const String home = 'Home';
  static const String directory = 'Directory';
  static const String calendar = 'Calendar';
  static const String inbox = 'Inbox';

  static const String readMore = 'readMore';
  static const String less = 'lessb';

}
