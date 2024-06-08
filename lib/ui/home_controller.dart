import 'package:couchsurfing_social/domain/model/app_profile.dart';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final PageController pageController = PageController();
  final AppProfile profile = AppProfile();

  int currentIndex = 0;
  String toRoute = "";

  @override
  void onInit() async {
    super.onInit();
    AppUtilities.logger.t("Home Controller Init");

    try {
      pageController.addListener(() {
        currentIndex = pageController.page!.toInt();
      });

      int toIndex =  0;

      if(Get.arguments != null) {
        if (Get.arguments[0] is int) {
          toIndex = Get.arguments[0] as int;
        } else if (Get.arguments[0] is String) {
          toRoute = Get.arguments[0] as String;
        }
      }

      if(!currentIndex.isEqual(toIndex) || currentIndex == 0) {
        selectPageView(toIndex);
      }

    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

  }

  @override
  void onReady() async {
    super.onReady();
    AppUtilities.logger.t("Home Controller Ready");

    if(toRoute.isNotEmpty) {
      await Get.toNamed(toRoute);
    }

    update();
  }

  void selectPageView(int index) async {
    AppUtilities.logger.t("Changing page view to index: $index");

    try {
      if(pageController.hasClients) {
        pageController.jumpToPage(index);
        currentIndex = index;
      }
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

    update();
  }

}
