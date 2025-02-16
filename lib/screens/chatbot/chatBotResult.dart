import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonCard.dart';
import 'package:ticklemickle_m/screens/chatbot/results/result_chatbot.dart';

class ChatBotResultScreen extends StatelessWidget {
  const ChatBotResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final result = lookalikeList[random.nextInt(3)];

    return Scaffold(
      appBar: AppBar(
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
          const SizedBox(height: 16),
          Center(
              child: Text(result.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold))),
          Center(
              child: Text(result.match,
                  style: const TextStyle(fontSize: 16, color: Colors.blue))),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(result.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: MyColors.lightGrey,
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
          const SizedBox(height: 32),
          for (var link in result.links)
            CommonCard(
              imagePath: link.imagePath,
              title: link.title,
              subtitle: link.detail,
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
