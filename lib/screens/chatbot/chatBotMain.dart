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
  List<Map<String, String>> selectedAnswers = []; // 사용자의 선택 저장
  int currentQuestionIndex = 0;
  bool isFirstMessage = true;
  bool isResultDisplayed = false; // 결과가 표시되었는지 체크

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addNextQuestion();
  }

  void _addNextQuestion([String? userResponse]) {
    if (userResponse != null) {
      setState(() {
        /* 첫 번째  */
        if (messages[currentQuestionIndex - 1]["answer"] != null) {
          print(messages[currentQuestionIndex - 1]);
          selectedAnswers.add({
            "question": messages.last["message"], // 마지막 질문과 연결
            "userPick": userResponse,
          });

          // messages.add({"type": "answer", "userPick": userResponse});
        }
      });
    }

    if (currentQuestionIndex < financeBasicTest.length) {
      setState(() {
        messages.add(financeBasicTest[currentQuestionIndex]);
        currentQuestionIndex++;
      });

      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) setState(() {});
      });
    } else {
      _displayFinalAnswers();
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });

    if (isFirstMessage) {
      isFirstMessage = false;
      Future.delayed(const Duration(seconds: 1), () {
        _addNextQuestion();
      });
    }
  }

  void _displayFinalAnswers() {
    if (isResultDisplayed) {
      print("마지막 질문까지 모두 제출됨.");
      context.go('/ChatBotResult');
      return;
    }

    setState(() {
      isResultDisplayed = true;
      // messages.add({
      //   "type": "text",
      //   "message": "재테크 현황 분석이 완료되었습니다.\n아래 정보를 제출하겠습니다.\n\n",
      // });

      // for (var finalAnswer in selectedAnswers) {
      //   messages.add({
      //     "type": "text",
      //     "message":
      //         "${finalAnswer["question"]}\n\n➡️ ${finalAnswer["answer"]}",
      //   });
      // }

      messages.add({
        "type": "choice",
        "options": ["위 내용으로 분석하기"],
        "message": """
재테크 현황 분석이 완료되었습니다.

${selectedAnswers.map((finalAnswer) => "• ${finalAnswer["question"]}\n➡️ ${finalAnswer["userPick"]}").join("\n\n")}
        """,
      });
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
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
