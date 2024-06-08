import 'package:couchsurfing_social/domain/model/post.dart';
import 'package:couchsurfing_social/ui/timeline_controller.dart';
import 'package:couchsurfing_social/ui/widgets/timeline_widgets.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TimelineCardContainer extends StatelessWidget {

  final TimelineController timelineController;
  final Post post;
  final Widget child;

  const TimelineCardContainer({required this.timelineController, required this.post, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    TimelineController _ = timelineController;
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(style: BorderStyle.solid, color: Colors.grey, width: 0.5)
      ),
      child: Card(
        color: AppColor.getContextCardColor(context),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              userAvatarSection(context, _.profile.id, post,),
              AppTheme.heightSpace10,
              child,
              AppTheme.heightSpace10,
              const Divider(thickness: 1),
              likeCommentShare(_, post),
            ],
          ),
        ),
      ),
    );
  }
}
