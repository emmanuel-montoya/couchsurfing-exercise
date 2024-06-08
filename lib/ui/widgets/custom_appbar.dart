import 'package:cached_network_image/cached_network_image.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:couchsurfing_social/utils/constants/app_constants.dart';
import 'package:couchsurfing_social/utils/constants/app_translation_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final String profileImg;
  final String profileId;

  const CustomAppBar({
    required this.title,
    required this.profileImg,
    required this.profileId,
    super.key
  });

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColor.appBar,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: CircleAvatar(
          maxRadius: 60,
          backgroundImage: CachedNetworkImageProvider(profileImg.isNotEmpty
              ? profileImg : AppConstants.noImageURL)
        ),
        onPressed: ()=> Scaffold.of(context).openDrawer(),
      ),
      title: GestureDetector(
          child: Row(
            children: [
              Image.asset(
                "assets/couchsurfing_logo.png",
                height: 60,
                width: 150,
              )
            ],
          ),
          onTap: () async {
            AppUtilities.showAlert(context, message: "${AppTranslationConstants.version.tr} - Exercise");
          }
      ),
      actionsIconTheme: const IconThemeData(size: 20),
      actions: <Widget>[
        Stack(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.notifications),
              color: Colors.white70,
              onPressed: ()=> {}
            )
          ],
        ),
        IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.search),
            color: Colors.white70,
            onPressed: ()=>{}
        ),
        IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.comment),
            color: Colors.white70,
            onPressed: ()=> {
            }
        ),
      ],
    );
  }

}
