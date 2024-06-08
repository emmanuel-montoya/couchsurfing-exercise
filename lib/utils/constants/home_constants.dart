
import 'package:couchsurfing_social/ui/widgets/menu_model.dart';
import 'package:couchsurfing_social/utils/constants/app_route_constants.dart';
import 'package:couchsurfing_social/utils/constants/app_translation_constants.dart';
import 'package:flutter/material.dart';

class HomeConstants {

  static const int firstTabIndex = 0;
  static const int secondTabIndex = 1;
  static const int thirdTabIndex = 2;
  static const int forthTabIndex = 3;

  static final List<MenuModel> bottomMenuItems = [
    MenuModel(AppTranslationConstants.createPost, AppTranslationConstants.createPostMsg, Icons.colorize, AppRouteConstants.postUpload),
    MenuModel(AppTranslationConstants.organizeEvent, AppTranslationConstants.organizeEventMsg, Icons.event, AppRouteConstants.createEventType),
    MenuModel(AppTranslationConstants.shareComment, AppTranslationConstants.shareCommentMsg, Icons.info, AppRouteConstants.createPostText),
  ];

}
