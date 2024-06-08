import 'package:flutter/material.dart';

class AppColor {

  static const Color appBlack = Color.fromRGBO(41,41,43, 1);

  static Color getMain() {
    Color mainColor = Colors.white;
    mainColor = const Color.fromRGBO(22, 42, 93, 1);
    return mainColor;
  }

  static Color main25 = getMain().withOpacity(0.25);
  static Color main50 = getMain().withOpacity(0.5);
  static Color main75 = getMain().withOpacity(0.75);
  static Color main95 = getMain().withOpacity(0.95);

  static final Color bottomNavigationBar = getMain().withOpacity(0.5);
  static final Color drawer = getMain().withOpacity(0.5);
  static final Color appBar = getMain().withOpacity(0.5);
  static final Color boxDecoration = getMain().withOpacity(0.3);

  static const Color white = Colors.white;

  static Color getContextCardColor(BuildContext context) {
    return Theme.of(context).cardColor.withOpacity(0.2);
  }

}
