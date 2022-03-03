import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetailController extends GetxController {
  VideoController? videoController;
  YoutubePlayerController? playerController;

  @override
  void onInit() {

    videoController = Get.find(tag: Get.parameters["videoId"]);
    playerController = YoutubePlayerController(
      initialVideoId: Get.parameters["videoId"]!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
    // print(videoController.video!.snippet!.title!);
    super.onInit();
  }

  String get title =>videoController!.video!.snippet!.title!;
  String get description =>videoController!.video!.snippet!.description!;
  String get viewCount => '조회수 ${videoController!.statistics.value.viewCount}회';
  String get likeCount => '조회수 ${videoController!.statistics.value.likeCount}';
  // String get dislikeCount => '조회수 ${videoController!.statistics.value.dislikeCount}';
  String get publishedTime => DateFormat('yyyy-MM-dd').format(videoController!.video!.snippet!.publishTime!);
  String get youtuberThumbnailUrl => videoController!.youtuberThumbnailUrl;
  String get youtuberName => videoController!.youtuber.value.snippet!.title!;

}