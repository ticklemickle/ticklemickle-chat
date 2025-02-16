import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'appListItem.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "title": "재테크 현황",
        "subtitle": "2025년 최신판",
        "image": "money.png",
        "participants": 35
      },
      {
        "title": "국내 주식 투자",
        "subtitle": "성향 분석",
        "image": "stockGraph.png",
        "participants": 12
      },
      {
        "title": "미국 주식 투자",
        "subtitle": "성향 분석",
        "image": "stockGraph.png",
        "participants": 5
      },
      {
        "title": "부동산(상가) 투자",
        "subtitle": "성향 분석",
        "image": "building.png",
        "participants": 35
      },
      {
        "title": "부동산(주택) 투자",
        "subtitle": "성향 분석",
        "image": "house.png",
        "participants": 325
      },
      {
        "title": "코인 투자",
        "subtitle": "성향 분석",
        "image": "bitcoin.png",
        "participants": 35
      },
      {
        "title": "금융 닮은꼴 찾기",
        "subtitle": "",
        "image": "happyface.png",
        "participants": 3675
      },
      {
        "title": "금융 닮은꼴 찾기",
        "subtitle": "",
        "image": "happyface.png",
        "participants": 3675
      },
      {
        "title": "금융 닮은꼴 찾기",
        "subtitle": "",
        "image": "happyface.png",
        "participants": 3675
      },
      {
        "title": "금융 닮은꼴 찾기",
        "subtitle": "",
        "image": "happyface.png",
        "participants": 3675
      },
      {
        "title": "금융 닮은꼴 찾기",
        "subtitle": "",
        "image": "happyface.png",
        "participants": 3675
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("경제 근육 키우기",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, size: 28),
            onPressed: () {
              context.push('/settingMain');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push('/ChatBotMain');
            },
            child: AppListItem(
              title: items[index]["title"],
              subtitle: items[index]["subtitle"],
              imagePath: "assets/icon3D/${items[index]["image"]}",
              participants: items[index]["participants"],
            ),
          );
        },
      ),
    );
  }
}
