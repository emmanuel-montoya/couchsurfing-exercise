import 'dart:collection';
import 'dart:core';
import 'package:couchsurfing_social/domain/model/app_profile.dart';
import 'package:couchsurfing_social/domain/model/post.dart';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:couchsurfing_social/utils/enums/post_type.dart';
import 'package:couchsurfing_social/utils/mocks/post_mocks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineController extends GetxController {


  final ScrollController timelineScrollController = ScrollController();

  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  final Rx<SplayTreeMap<double, Post>> sortedPostLocation = SplayTreeMap<double, Post>().obs;
  final AppProfile profile = AppProfile();

  final RxBool isLoading = true.obs;
  final RxMap<String, Post> posts = <String, Post>{}.obs;

  bool isUploading = false;
  bool isLiked = false;

  @override
  void onInit() async {
    super.onInit();
    AppUtilities.logger.t("Timeline Controller Init");

    try{
      if(Get.arguments != null) {
        if(Get.arguments is Map<String, Post>) {
          posts.value = Get.arguments as Map<String, Post>;
        }
      }

      timelineScrollController.addListener(_timelineScrollListener);
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }
  }

  @override
  void onReady() async {
    super.onReady();

    try {
      if(posts.value.isEmpty) await getTimeline();
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

    AppUtilities.logger.t("Timeline Controller Ready");
    isLoading.value = false;
    update();
  }

  void _timelineScrollListener() async {
    try {

      double maxScrollExtent = timelineScrollController.position.maxScrollExtent;

      if (timelineScrollController.offset >= maxScrollExtent
          && !timelineScrollController.position.outOfRange
      ) {
        AppUtilities.logger.d("Timeline Bottom Reached");


      }

      if (timelineScrollController.offset <= timelineScrollController.position.minScrollExtent &&
          !timelineScrollController.position.outOfRange) {
        AppUtilities.logger.d("Scrolling cool");
      }
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

    update();
  }

  Future<void> getTimeline() async {
    AppUtilities.logger.t("Refreshing timeline");
    try {
      //MOCKUPS
      for (var mockPost in mockPosts) {
        posts[mockPost.id] = mockPost;
      }


      if(posts.value.isNotEmpty) {
        for(Post post in posts.value.values) {
          switch(post.type) {
            case PostType.image:
            // TODO: Handle this case.
              break;
            case PostType.video:
            // TODO: Handle this case.
              break;
            case PostType.caption:
            // TODO: Handle this case.
              break;
          }

        }

        sortTimeline();
      }
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }

    isLoading.value = false;
    update();
  }

  bool isLikedPost(Post post) {
    return post.likedProfiles.contains(profile.id);
  }

  Future<void> handleLikePost(Post post) async {
    isLiked = isLikedPost(post);

    isLiked ? post.likedProfiles.remove(profile.id) : post.likedProfiles.add(profile.id);
    posts.value[post.id] = post;

    update();
  }

  void handleLikeOnPost(Post post) {
    isLiked = post.likedProfiles.contains(profile.id);
    if(posts.value[post.id] != null) {
      posts.value[post.id]!.likedProfiles = post.likedProfiles;
    }
    update();
  }

  void sortTimeline() {
    AppUtilities.logger.t("Sorting posts.value by position");
    try {
      posts.value.values.toList().reversed.forEach((post) {
        if(profile.position != null && post.position != null
            && post.position!.latitude != 0.0 && post.position!.altitude != 0.0) {
          double distance = AppUtilities.distanceBetweenPositionsRounded(profile.position!, post.position!).toDouble();
          distance = distance + (post.createdTime * 0.0000000000001);
          sortedPostLocation.value[distance] = post;
        }
      });
    } catch (e) {
      AppUtilities.logger.e(e.toString());
    }
  }

}
