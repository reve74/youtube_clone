import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/app.dart';
import 'package:youtube_clone/src/binding/init_binding.dart';
import 'package:youtube_clone/src/components/youtube_detail.dart';
import 'package:youtube_clone/src/pages/search.dart';

import 'controller/youtube_detail_controller.dart';
import 'controller/youtube_search_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube Clone',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      initialBinding: InitBinding(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => App()),
        GetPage(
          name: "/detail/:videoId",
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(() => Get.lazyPut<YoutubeDetailController>(
              () => YoutubeDetailController())),
        ),
        GetPage(
          name: "/search/",
          page: () => YoutubeSearch(),
          binding: BindingsBuilder(() => Get.lazyPut<YoutubeSearchController>(
                  () => YoutubeSearchController())),
        ),
      ],
    );
  }
}
