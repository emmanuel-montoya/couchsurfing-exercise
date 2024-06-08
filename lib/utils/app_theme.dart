import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static const SizedBox heightSpace100 = SizedBox(height: 100);
  static const SizedBox heightSpace75 = SizedBox(height: 75);
  static const SizedBox heightSpace50 = SizedBox(height: 50);
  static const SizedBox heightSpace40 = SizedBox(height: 40);
  static const SizedBox heightSpace30 = SizedBox(height: 30);
  static const SizedBox heightSpace20 = SizedBox(height: 20);
  static const SizedBox heightSpace10 = SizedBox(height: 10);
  static const SizedBox heightSpace5 = SizedBox(height: 5);

  static const SizedBox widthSpace20 = SizedBox(width: 20);
  static const SizedBox widthSpace15 = SizedBox(width: 15);
  static const SizedBox widthSpace10 = SizedBox(width: 10);
  static const SizedBox widthSpace5 = SizedBox(width: 5);

  static BoxDecoration appBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [
      AppColor.main75,
      AppColor.main50
    ],
      begin: FractionalOffset.topRight,
      end: FractionalOffset.bottomLeft, //FractionalOffset(1.0, 1.0)
    ),
  );

  static const double postIconSize = 20;

}
