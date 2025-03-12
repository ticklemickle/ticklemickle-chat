import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/BackButtonHandler.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';
import 'package:ticklemickle_m/common/widgets/commonCard.dart';
import 'package:ticklemickle_m/common/widgets/commonShareLink.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/linkResult.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/lookalike_answerList.dart';

class ChatBotLookalikeScreen extends StatelessWidget {
  const ChatBotLookalikeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final result = lookalikeList[random.nextInt(3)];

    final commonCardResult = getchatBotResultLink(jsonList: [
      {
        "level": 2,
        "title": "한국의 ${result.name} 모임",
      },
    ]);

    return BackButtonHandler(
      onBackButtonPressed: () async {
        context.go(RouteConst.appHome);
        return false;
      },
      child: Scaffold(
        appBar: CommonAppBar(
          title: '금융 닮은 꼴 결과',
          useAppHome: true,
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
            const SizedBox(height: 50),
            Commonsharelink(),
            const SizedBox(height: 40),
            for (var link in commonCardResult.links)
              CommonCard(
                imagePath: link.imagePath,
                title: link.title ?? "",
                subtitle: link.detail,
                onTap: () => handleCardTap(context, link),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
