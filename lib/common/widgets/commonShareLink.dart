import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class Commonsharelink extends StatelessWidget {
  const Commonsharelink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: MyColors.lightestGrey,
          child: IconButton(
            icon: const Icon(Icons.share),
            color: MyColors.mainDarkColor,
            onPressed: () {
              // 공유하기 버튼 onPressed 로직 추가
            },
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            print("kako 공유하기");
            // 추가 공유 로직이 있다면 여기에 구현
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: MyColors.kakaoColor,
            child: Image.asset(
              "assets/chatbot/result/common/kakao_share.png",
              width: 30,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
