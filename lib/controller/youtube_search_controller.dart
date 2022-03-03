import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/models/youtube_video_result.dart';
import 'package:youtube_clone/repository/youtube_repository.dart';

class YoutubeSearchController extends GetxController {
  String key = 'searchKey';
  RxList<String> history = RxList<String>.empty(growable: true);
  SharedPreferences? profs;
  ScrollController scrollController = ScrollController();
  String? _currentKeyword;
  Rx<YoutubeVideoResult>? youtubeVideoResult =
      YoutubeVideoResult(items: []).obs;

  @override
  void onInit() async {
    _event();
    profs = await SharedPreferences.getInstance();
    List<dynamic>? initData = (profs!.get(key) ?? []) as List?;
    history(initData!.map((_) => _.toString()).toList());
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      // print(scrollController.position.pixels);
      print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeVideoResult!.value.nextPagetoken != "") {
        _searchYoutube(_currentKeyword!);
      }
    });
  }

  void submitSearch(String searchKey) {
    history.addIf(!history.contains(searchKey), searchKey);
    profs!.setStringList(key, history);
    _currentKeyword = searchKey;
    _searchYoutube(searchKey);
  }

  void _searchYoutube(String searchKey) async {
    YoutubeVideoResult? youtubeVideoResultFromServer = await YoutubeRepository
        .to
        .search(searchKey, youtubeVideoResult!.value.nextPagetoken ?? "");
    youtubeVideoResult!(youtubeVideoResultFromServer);
    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items!.length > 0) {
      youtubeVideoResult!.update((youtube) {
        youtube!.nextPagetoken = youtubeVideoResultFromServer.nextPagetoken;
        youtube.items!.addAll(youtubeVideoResultFromServer.items!);
      });
    }
  }
}

// class YoutubeSearchController extends GetxController { // 방법 1
//
//   String key = 'searchKey';
//   RxList<String> history = RxList<String>.empty(growable: true);
//   Set<String>? originHistory = {};
//   SharedPreferences? profs;
//   @override
//   void onInit() async{
//     profs = await SharedPreferences.getInstance();
//     List<dynamic>? initData = (profs!.get(key) ?? []) as List?;
//     originHistory?.addAll(initData!.map((_) => _.toString()).toList());
//     history(originHistory!.toList());
//     super.onInit();
//   }
//
//   void search(String search) {
//     history.clear();
//     originHistory!.add(search);
//     history.addAll(originHistory!.toList());
//     profs!.setStringList(key, originHistory!.toList());
//   }
// }
