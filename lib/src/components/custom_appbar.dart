import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  Widget _logo() {
    return Container(
      child: Row(
        children: [
          Image.asset('assets/images/logo1.png', width: 100,),
          // Text('Premiun', style: TextStyle(color: Colors.black,),)
        ],
      ),
    );
  }

  Widget _actions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
          },
          child: Container(
            width: 23,
            height: 23,
            child: SvgPicture.asset('assets/svg/icons/bell.svg'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GestureDetector(
            onTap: () {
              Get.toNamed("/search");
            },
            child: Container(
              width: 30,
              height: 30,
              child: SvgPicture.asset('assets/svg/icons/search.svg'),
            ),
          ),
        ),
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.grey.withOpacity(0.5),
          backgroundImage: Image.network('https://yt3.ggpht.com/ytc/AKedOLQf9XARnp2yzFCo9D8hFKckDRRtCXDJTcYLY2wwRw=s88-c-k-c0x00ffffff-no-rj').image,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _logo(),
          _actions(),
        ],
      ),
    );
  }
}
