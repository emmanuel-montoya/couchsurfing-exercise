import 'package:couchsurfing_social/ui/timeline_page.dart';
import 'package:couchsurfing_social/ui/widgets/custom_appbar.dart';
import 'package:couchsurfing_social/ui/widgets/custom_bottom_app_bar.dart';
import 'package:couchsurfing_social/ui/widgets/custom_bottom_bar_item.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/constants/app_constants.dart';
import 'package:couchsurfing_social/utils/constants/app_translation_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.red,
        appBar: CustomAppBar(
            title: AppConstants.appTitle,
            profileImg: _.profile.photoUrl.isNotEmpty
            ? _.profile.photoUrl : "https://m.media-amazon.com/images/I/A1LJA3O-9LL._UF1000,1000_QL80_.jpg",
            profileId: _.profile.id),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.main50,
                ),
                child: Text('Profile Info'),
              ),
              ListTile(
                title: const Text('Option 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Option 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _.pageController,
              children: const [TimelinePage(),]
            ),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
          child: CustomBottomAppBar(
            backgroundColor: AppColor.bottomNavigationBar,
            color: Colors.white30,
            selectedColor: Colors.white,
            notchedShape: const CircularNotchedRectangle(),
            iconSize: 20.0,
            onTabSelected:(int index) => _.selectPageView(index),
            items: [
              CustomBottomAppBarItem(iconData: Icons.house, text: AppTranslationConstants.home.tr),
              CustomBottomAppBarItem(iconData: Icons.store_mall_directory, text: AppTranslationConstants.directory.tr),
              CustomBottomAppBarItem(iconData: Icons.calendar_month, text: AppTranslationConstants.calendar.tr),
              CustomBottomAppBarItem(iconData: Icons.message, text: AppTranslationConstants.inbox.tr,)
            ],
          ),
        ),
      ),
    );
  }

}
