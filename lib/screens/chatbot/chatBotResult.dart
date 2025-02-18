import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonAlertsheet.dart';
import 'package:ticklemickle_m/common/widgets/commonCard.dart';
import 'package:ticklemickle_m/screens/chatbot/results/result_chatbot.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBotResultScreen extends StatelessWidget {
  const ChatBotResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final result = lookalikeList[random.nextInt(3)];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("금융 닮은꼴 찾기 결과"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.go('/AppHome');
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Image.asset(result.image,
                width: 200, height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(height: 25),
          Center(
              child: Text(result.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w600))),
          Center(
              child: Text(result.match,
                  style: const TextStyle(fontSize: 16, color: Colors.blue))),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(result.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 25),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.grey[300],
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          //     ),
          //     child: const Text("더보기", style: TextStyle(color: Colors.black)),
          //   ),
          // ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: MyColors.lightestGrey,
                child: IconButton(
                  icon: const Icon(Icons.share),
                  color: MyColors.mainDarkColor,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  print("kako 공유하기");
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
          ),
          const SizedBox(height: 40),
          for (var link in result.links)
            CommonCard(
              imagePath: link.imagePath,
              title: link.title,
              subtitle: link.detail,
              onTap: () {
                link.level == 1
                    ? launchUrl(Uri.parse('https://open.kakao.com/o/gLztSsgh'))
                    : showCommonAlertSheet(
                        context: context,
                        title: link.title,
                        subTitle: link.detail,
                        content: (link.level == 2)
                            ? "본 모임은 4,900 원 유료 모임입니다. \n실명으로만 단체 카톡방 참석 가능합니다.\n성향 분석 결과와 유사한 투자 성향을 가진 사람들끼리 모입니다.\n결제가 완료되면, 담당자가 단체 카톡방에 초대해 드립니다."
                            : "본 모임은 50,000 원 유료 모임입니다.\n실명으로만 단체 카톡방 참석 가능합니다.\n성향 분석 결과와 유사한 투자 성향을 갖은 사람들끼리 모입니다.\n소득, 자산, 직업, 지역 등을 종합적으로 고려하여 최적의 멤버들과 그룹을 구성합니다.\n결제가 완료되면, 담당자가 단체 카톡방에 초대해드립니다.",
                        confirmText: "동의하고 결제하기",
                        onConfirm: () {
                          Navigator.pop(context); // 팝업 닫기
                        },
                        cancelText: "닫기",
                        onCancel: () => Navigator.pop(context),
                      );
              },
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
