import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/controller/video_controller.dart';
import 'package:youtube_clone/models/video.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({Key? key, this.video}) : super(key: key);

  final Video? video;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoController? _controller;

  @override
  void initState() {
    _controller = Get.put(VideoController(video: widget.video),
        tag: widget.video!.id!.videoId!);
    super.initState();
  }

  Widget _thumbnail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.grey.withOpacity(0.5),
          child: CachedNetworkImage(  //로드 시 전체를 이니셜라이즈 하지 않고 세개 우선 처리
            imageUrl: widget.video!.snippet!.thumbnails!.medium!.url!,
            placeholder: (context, url) => Container( // 로드 중 인디케이터 처리
              height: 230,
              child: Center(child: CircularProgressIndicator()),
            ),
            fit: BoxFit.fitWidth,
          ),
          // child: Image.network(
          //   widget.video!.snippet!.thumbnails!.medium!.url!,
          //   fit: BoxFit.fitWidth,
          // ),
        ),
      ],
    );
  }

  Widget _simpleDetailInfo() {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 10),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage:
                  Image.network(_controller!.youtuberThumbnailUrl).image,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.video!.snippet!.title!,
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.video!.snippet!.channelTitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const Text(' · '),
                    Obx(
                      () => Text(
                        _controller!.viewCountString,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const Text(' · '),
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(widget.video!.snippet!.publishTime!),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _thumbnail(),
          _simpleDetailInfo(),
        ],
      ),
    );
  }
}
