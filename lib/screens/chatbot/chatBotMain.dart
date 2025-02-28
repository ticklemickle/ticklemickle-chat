import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';
import 'dart:async';
import 'widget/messageWidget.dart';
import 'package:ticklemickle_m/screens/chatbot/questions/chatbotQuestions.dart';

class ChatBotScreen extends StatefulWidget {
  final String category;

  const ChatBotScreen({Key? key, required this.category}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late String category;
  late final List<Map<String, dynamic>> questionList;

  List<Map<String, dynamic>> messages = []; // 대화 내역 저장
  List<Map<String, String>> userPickMessage = []; // 사용자의 선택 저장
  int totalQuestions = 0;
  int currentQuestionIndex = 0;
  int messageIndex = 0;
  bool isFirstMessage = true;
  bool isResultDisplayed = false; // 결과가 표시되었는지 체크

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    category = widget.category;
    questionList = getQuestionsList(category);
    totalQuestions = questionList.length;
    _addNextQuestion();
  }

  void _addNextQuestion([String? userResponse]) {
    if (userResponse != null) {
      setState(() {
        print(userResponse.toString());

        if (userResponse.toString() == "변경하기") {
          print("IN");
          return;
        }

        String upperResponse = userResponse;
        if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(upperResponse)) {
          upperResponse = upperResponse.toUpperCase();
        }

        if (messages[messageIndex - 1]["answer"] != null) {
          userPickMessage.add({
            "question": messages.last["message"], // 마지막 질문과 연결
            "message": upperResponse,
          });
          messages.add({"type": "userPick", "message": upperResponse});
          messageIndex++;
        }
      });
    }

    if (currentQuestionIndex < questionList.length) {
      setState(() {
        messages.add(questionList[currentQuestionIndex]);
        currentQuestionIndex++;
        messageIndex++;
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
      // context.go('/ChatBotResult');
      context.go('/ChatBotResult_common?category=$category');
      return;
    }

    setState(() {
      isResultDisplayed = true;
      messages.add({
        "type": "choice",
        "options": ["위 내용으로 분석하기"],
        "message": """
재테크 현황 분석이 완료되었습니다.

${userPickMessage.map((userPick) => "• ${userPick["question"]}\n➡️ ${userPick["message"]}").join("\n\n")}
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
      appBar: CommonAppBar(
        title: '금융 지식 테스트',
        useAppHome: true,
      ),
      body: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
                begin: 0.0, end: currentQuestionIndex / totalQuestions),
            duration: Duration(seconds: 1), // 애니메이션 지속 시간
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: MyColors.lightGrey,
                valueColor: AlwaysStoppedAnimation<Color>(MyColors.mainColor),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: messages
                    .map((message) => MessageWidget(
                          key: ValueKey(message), // Key 추가하여 위젯 재사용
                          messageData: message,
                          onAnswerSelected: _addNextQuestion,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
