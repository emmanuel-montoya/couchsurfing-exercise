import 'package:auto_size_text/auto_size_text.dart';
import 'package:couchsurfing_social/domain/model/post.dart';
import 'package:couchsurfing_social/ui/timeline_controller.dart';
import 'package:couchsurfing_social/ui/widgets/read_more_container.dart';
import 'package:couchsurfing_social/ui/widgets/timeline_widgets.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/app_theme.dart';
import 'package:couchsurfing_social/utils/app_utilities.dart';
import 'package:couchsurfing_social/utils/constants/app_route_constants.dart';
import 'package:couchsurfing_social/utils/enums/post_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'timeline_card_container.dart';

Widget getTimelineItem(TimelineController _, Post post, BuildContext context, int index) {

  Widget timelineItem = Container();

  AppUtilities.logger.t("Loading Post ${post.id}");
    switch (post.type) {
      case PostType.caption:
        timelineItem = feedNewsCardWithText(
            context, _, post);
        break;
      case PostType.image:
        timelineItem = feedNewsCardWithMedia(
            context, _, post);
        break;
      case PostType.video:
        timelineItem = feedNewsCardWithMedia(
            context, _, post);
        break;
    }

  return timelineItem;
}

Widget feedNewsCardWithText(BuildContext context, TimelineController _, Post post) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(style: BorderStyle.solid, color: Colors.grey, width: 0.5)
    ),
    child: Card(
        color: AppColor.getContextCardColor(context),
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              userAvatarSection(context, _.profile.id, post),
              AppTheme.heightSpace10,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0x36FFFFFF).withOpacity(0.05),
                          const Color(0x0FFFFFFF).withOpacity(0.05)
                        ],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: post.caption.isNotEmpty ?
                Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      post.caption.capitalizeFirst,
                      minFontSize: 35,
                      maxFontSize: 50,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )
                ) : Container(),
              ),
              const Divider(thickness: 1),
              likeCommentShare(_, post),
            ],
          ),
        )
    ),
  );
}

Widget feedNewsCardWithMedia(BuildContext context, TimelineController _, Post post) {
  return TimelineCardContainer(
    timelineController: _,
    post: post,
    child: Column(
      children: <Widget>[
        post.caption.length > 500 ? Align(
          alignment: Alignment.centerLeft,
          child: ReadMoreContainer(text: post.caption,padding: 0, fontSize: 14),
        ) : post.caption.isNotEmpty ?
        Align(alignment: Alignment.centerLeft,
          child: Text(post.caption, maxLines: 12,)
        ) : Container(),
        AppTheme.heightSpace10,
        GestureDetector(
          child: customCachedNetworkHeroImage(post.mediaUrl),
          onTap: () => Get.toNamed(AppRouteConstants.postDetails, arguments: [post]),
        ),
      ],
    ),
  );
}
