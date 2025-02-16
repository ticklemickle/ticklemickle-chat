import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'messageWidget.dart';
import 'package:ticklemickle_m/screens/chatbot/questions/basicTest.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  List<Map<String, dynamic>> messages = []; // 대화 내역 저장
  int currentQuestionIndex = 0; // 현재 질문 인덱스
  bool isFirstMessage = true; // 첫 메시지 체크

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addNextQuestion();
  }

  void _addNextQuestion([String? userResponse]) {
    if (userResponse != null) {
      setState(() {
        messages.add({"type": "answer", "message": userResponse});
      });
    }

    if (currentQuestionIndex < financeBasicTest.length) {
      setState(() {
        messages.add(financeBasicTest[currentQuestionIndex]);
        currentQuestionIndex++;
      });

      // **Web에서 setState 강제 리빌드 문제 해결을 위해 딜레이 적용**
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      print("마지막 질문까지 모두 제출됨.");
      context.go('/ChatBotResult');
    }

    // 애니메이션 효과 및 스크롤 이동
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });

    // 첫 번째 메시지 이후, 자동으로 다음 질문 표시 (인사말 처리)
    if (isFirstMessage) {
      isFirstMessage = false;
      Future.delayed(const Duration(seconds: 1), () {
        _addNextQuestion();
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("금융 지식 테스트"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageWidget(
                  messageData: messages[index],
                  onAnswerSelected: _addNextQuestion,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
