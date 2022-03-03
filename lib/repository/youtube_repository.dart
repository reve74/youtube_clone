import 'package:get/get.dart';
import 'package:youtube_clone/models/statistics.dart';
import 'package:youtube_clone/models/youtube_video_result.dart';
import 'package:youtube_clone/models/youtuber.dart';

class YoutubeRepository extends GetConnect {
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "https://www.googleapis.com";
    super.onInit();
  }

  Future<YoutubeVideoResult?> loadVideos(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&channelId=UCD2YO_A_PVMgMDN9jpRrpVA&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyCRkfnlzXvzaxvIVjgr-gbLFRNTrQqwNiQ&pageToken=$nextPageToken";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
      // print(response.body['items']);
    }
  }

  Future<YoutubeVideoResult?> search(
      String searchKeyword, String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyCRkfnlzXvzaxvIVjgr-gbLFRNTrQqwNiQ&pageToken=$nextPageToken&q=$searchKeyword";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
      // print(response.body['items']);
    }
  }

  Future<Statistics?> getViewInfoById(String videoId) async {
    String url =
        "/youtube/v3/videos?part=statistics&key=AIzaSyCRkfnlzXvzaxvIVjgr-gbLFRNTrQqwNiQ&id=$videoId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        Map<String, dynamic> data = response.body['items'][0];
        return Statistics.fromJson(data['statistics']);
      }
    }
  }

  Future<Youtuber?> getYoutuberInfoById(String channelId) async {
    String url =
        "/youtube/v3/channels?part=statistics,snippet&key=AIzaSyCRkfnlzXvzaxvIVjgr-gbLFRNTrQqwNiQ&id=$channelId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      if (response.body['items'] != null && response.body['items'].length > 0) {
        Map<String, dynamic> data = response.body['items'][0];
        return Youtuber.fromJson(data);
      }
    }
  }
}
