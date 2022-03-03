import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class YoutubeBottomSheet extends StatelessWidget {
  const YoutubeBottomSheet({Key? key}) : super(key: key);

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '만들기',
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.close,
          ),
        ),
      ],
    );
  }

  Widget _itemButton(
      {String? icon, double? iconSize, String? label, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.3),
            ),
            width: 50,
            height: 50,
            child: Center(
              child: Container(
                child: SvgPicture.asset('assets/svg/icons/$icon.svg'),
                width: iconSize,
                height: iconSize,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Text(label!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 10),
            _itemButton(
              icon: 'upload',
              iconSize: 17,
              label: '동영상 업로드',
              onTap: () {
                print('동영상 업로드 구현');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            _itemButton(
              icon: 'broadcast',
              iconSize: 25,
              label: '실시간 스트리밍 시작',
              onTap: () {
                print('실시간 스트리밍 시작가능');
              },
            ),
          ],
        ),
      ),
    );
  }
}
