import 'package:get/get.dart';
import 'package:youtube_clone/models/statistics.dart';
import 'package:youtube_clone/models/video.dart';
import 'package:youtube_clone/models/youtuber.dart';
import 'package:youtube_clone/repository/youtube_repository.dart';

class VideoController extends GetxController {
  Video? video;

  VideoController({this.video});

  Rx<Statistics> statistics = Statistics().obs; // 빈값으로 초기화
  Rx<Youtuber> youtuber = Youtuber().obs;

  @override
  void onInit() async {
    Statistics? loadStatistics =
        await YoutubeRepository.to.getViewInfoById(video!.id!.videoId!);
    statistics(loadStatistics);
    Youtuber? loadYoutuber = await YoutubeRepository.to
        .getYoutuberInfoById(video!.snippet!.channelId!);
    youtuber(loadYoutuber);
    super.onInit();
  }

  String get viewCountString => '조회수 ${statistics.value.viewCount ?? '-'}회';

  String get youtuberThumbnailUrl {
    if (youtuber.value.snippet == null)
      return "https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png";
    return youtuber.value.snippet!.thumbnails!.medium!.url!;
  }
}
