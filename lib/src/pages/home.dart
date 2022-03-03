import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/controller/home_controller.dart';
import 'package:youtube_clone/src/components/custom_appbar.dart';
import 'package:youtube_clone/src/components/video_widget.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            const SliverAppBar(
              title: CustomAppBar(),
              floating: true,
              //floating, snap 을 true로 주면 스크롤을 내리다가 올리면 appBar가 다시 나옴
              snap: true,
            ),
            SliverList(
              // 스크롤 하면 앱바가 사라짐
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed('/detail/${controller.youtubeResult.value.items![index].id!.videoId}');
                    },
                    child: VideoWidget(
                      video: controller.youtubeResult.value.items![index],
                    ),
                  );
                },
                childCount: controller.youtubeResult.value.items == null
                    ? 0
                    : controller.youtubeResult.value.items!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
