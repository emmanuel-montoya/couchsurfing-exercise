import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:couchsurfing_social/domain/model/post.dart';
import 'package:couchsurfing_social/ui/timeline_controller.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/app_theme.dart';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:couchsurfing_social/utils/constants/app_constants.dart';
import 'package:couchsurfing_social/utils/constants/app_route_constants.dart';
import 'package:couchsurfing_social/utils/enums/post_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget userAvatarSection(BuildContext context, String profileId,  Post post,) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                post.profileImgUrl.isNotEmpty ?
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => profileId == post.ownerId ? Get.toNamed(AppRouteConstants.profile)
                          : Get.toNamed(AppRouteConstants.mateDetails, arguments: post.ownerId),
                      child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(post.profileImgUrl),
                          radius: 20
                      ),
                    ),
                    AppTheme.widthSpace10,
                  ],
                ) : Container(),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: GestureDetector(
                                    onTap: () => profileId == post.ownerId
                                        ? Get.toNamed(AppRouteConstants.profile)
                                        : Get.toNamed(AppRouteConstants.mateDetails, arguments: post.ownerId),
                                    child: Text(post.profileName.length < AppConstants.maxProfileNameLength
                                        ? post.profileName.capitalize
                                        : "${post.profileName.substring(0, AppConstants.maxProfileNameLength)}...",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        )
                                    ),
                                  ),
                                ),
                                AppTheme.widthSpace5,
                            ]),
                            AppTheme.widthSpace10,
                            post.profileName.length > AppConstants.maxProfileNameLength
                                ? Container()
                                : Text(getGenericPostType(post.type).tr,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey
                                )
                            )
                          ]
                      ),
                      ((post.profileName.length > AppConstants.maxProfileNameLength)
                          && getGenericPostType(post.type).isNotEmpty)
                          ? Text(getGenericPostType(post.type).tr,
                          softWrap: true,
                          style: const TextStyle(fontSize: 12, color: Colors.grey)
                      ) : Container(),
                      Row(
                          children: [
                            Text(AppUtilities.getTimeAgo(post.createdTime),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColor.white
                                )
                            ),
                            AppTheme.widthSpace5,
                            const Icon(Icons.public, color: Colors.white, size: 12,),
                            post.location.isNotEmpty ?
                            Row(
                              children: [
                                AppTheme.widthSpace5,
                                const Icon(Icons.location_on, color: Colors.white, size: 12,),
                                AppTheme.widthSpace5,
                                Text(post.location.length <= AppConstants.maxLocationNameLength
                                    ? post.location.capitalize
                                    : "${post.location.substring(0,AppConstants.maxLocationNameLength).capitalize}...",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white
                                    )
                                )
                              ],
                            ) : Container(),
                          ])
                    ])
              ],
            ),
          ],
        ),
      )
    ],
  );
}

String getGenericPostType(PostType postType){

  String genericPostType = "";

  switch(postType) {
    case PostType.caption:
      genericPostType = "";
      break;
    case PostType.image:
      genericPostType = "";
      break;
    case PostType.video:
      break;
  }

  return genericPostType;
}

Widget customCachedNetworkHeroImage(mediaUrl) {
  AppUtilities.logger.t("Building hero widget for image url: $mediaUrl");
  return Hero(
    //TODO Improve removing random int to get real hero functionality
    tag: 'img_${mediaUrl}_${Random().nextInt(1000)}',
    child: CachedNetworkImage(
      imageUrl: mediaUrl,
      fit: BoxFit.fill,
      errorWidget: (context,url,error) => const Icon(
        Icons.image_not_supported,
      ),
    ),
  );
}

Widget likeCommentShare(TimelineController _, Post post) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextButton(
            onPressed: () async => await _.handleLikePost(post),
            onLongPress: () => Get.toNamed(AppRouteConstants.likedProfiles, arguments: post.likedProfiles),
            child: Row(
              children: <Widget>[
                const Icon(Icons.heart_broken,
                    size: AppTheme.postIconSize,
                    color: AppColor.white),
                AppTheme.widthSpace5,
                Text('${post.likedProfiles.length}',
                  style: const TextStyle(color: AppColor.white),
                )
              ],
            )
        ),
        TextButton(
            onPressed: () => Get.toNamed(AppRouteConstants.postComments, arguments: post),
            child: Row(
              children: <Widget>[
                const Icon(Icons.comment_outlined,
                    size: AppTheme.postIconSize,
                    color: AppColor.white),
                AppTheme.widthSpace5,
                Text(post.commentIds.length.toString(),
                  style: const TextStyle(color: AppColor.white),
                )
              ],
            )
        ),
        IconButton(
          icon: const Icon(Icons.share,
              size: AppTheme.postIconSize,
              color: AppColor.white
          ),
          onPressed: () {},
        ),
      ]
  );
}