import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';

class MyInfo extends StatelessWidget {
  final bool useAppHome;
  const MyInfo({super.key, required this.useAppHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: '내 정보 수정',
        useAppHome: useAppHome,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: '닉네임',
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLength: 50,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: '지역',
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLength: 100,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: '생년월일',
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLength: 8,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: '성별',
                isDense: true,
                contentPadding: EdgeInsets.all(10),
              ),
              maxLength: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 저장 로직 처리
              },
              child: const Text('저장'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 로그아웃 처리
              },
              child: const Text('로그아웃'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // primary → backgroundColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
