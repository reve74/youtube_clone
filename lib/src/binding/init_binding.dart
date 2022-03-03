import 'package:get/get.dart';
import 'package:youtube_clone/controller/app_controller.dart';
import 'package:youtube_clone/repository/youtube_repository.dart';

class InitBinding implements Bindings{

  @override
  void dependencies() {
    Get.put(YoutubeRepository(), permanent: true);
    Get.put(AppController());
  }
}