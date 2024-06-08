import 'package:couchsurfing_social/domain/model/post.dart';
import 'package:couchsurfing_social/ui/widgets/timeline_items.dart';
import 'package:couchsurfing_social/utils/app_color.dart';
import 'package:couchsurfing_social/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'timeline_controller.dart';

class TimelinePage extends StatelessWidget {

  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TimelineController>(
      init: TimelineController(),
      builder: (_)=> Scaffold(
        backgroundColor: AppColor.main50,
        body: Container(
          decoration: AppTheme.appBoxDecoration,
          child: Obx(()=> _.isLoading.value ?
          const Center(child: CircularProgressIndicator())
           : RefreshIndicator(
              child: Stack(
                children: [
                  ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    controller: _.timelineScrollController,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => AppTheme.heightSpace5,
                    itemCount: _.posts.value.length,
                    itemBuilder: (context, index) {
                      Post post = _.posts.value.values.elementAt(index);
                      return getTimelineItem(_, post, context, index);
                    }
                  ),
                ],
              ),
              onRefresh: () => _.getTimeline()
            )
          ),
        )
      )
    );
  }

}
