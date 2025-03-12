import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/commonAppBar.dart';
import 'package:ticklemickle_m/screens/chatbot/widget/calculateScores.dart';
import 'package:ticklemickle_m/screens/home/appList/appfinanceList.dart';
import 'dart:async';
import 'widget/messageWidget.dart';
import 'package:ticklemickle_m/screens/chatbot/questions/chatbotQuestions.dart';

class ChatBotFinance extends StatefulWidget {
  final String category;

  const ChatBotFinance({Key? key, required this.category}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotFinance> {
  late String category;
  late final List<Map<String, dynamic>> questionList;
  List<String> _pendingMultiChoices = [];
  List<Map<String, dynamic>> messages = []; // 대화 내역 저장
  List<Map<String, dynamic>> userPickMessage = []; // 사용자의 선택 저장
  int totalQuestions = 0;
  int currentQuestionIndex = 0;
  int messageIndex = 0;
  bool isFirstMessage = true;
  bool isResultDisplayed = false;
  bool isAdded = false;
  bool _isLoading = true; // 로딩 여부 상태 변수

  Map<String, int> userAnswerMap = {
    "income": 0,
    "assets": 0,
    "spend": 0,
    "saved": 0,
  };

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    category = widget.category;
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    questionList = await getQuestionsListFromFirebase(category);
    totalQuestions = questionList.length;
    setState(() {
      _isLoading = false;
    });
    _addNextQuestion();
  }

  void _addNextQuestion([String? userResponse]) {
    if (userResponse != null) {
      setState(() {
        if (userResponse.toString() == "변경하기") {
          print("변경하기");
          return;
        }

        String upperResponse = userResponse;
        if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(upperResponse)) {
          upperResponse = upperResponse.toUpperCase();
        }

        if (messages[messageIndex - 1]["type"] != "text" &&
            messages[messageIndex - 1]["type"] != "multi-choice" &&
            messages[messageIndex - 1]["type"] != "userPick" &&
            messages[messageIndex - 1]["type"] != "basic") {
          userPickMessage.add({
            "message": messages.last["message"],
            "goal": messages.last["goal"],
            "options": messages.last["options"],
            "userResponse": upperResponse,
          });
          messages.add({"type": "userPick", "message": upperResponse});
          messageIndex++;
        }

        if (messages[messageIndex - 1]["type"] == "multi-choice") {
          if (upperResponse == "") {
            messageIndex++;
          } else {
            if (_pendingMultiChoices.isEmpty) {
              _pendingMultiChoices =
                  userResponse.split(',').map((item) => item.trim()).toList();
            }
            if (_pendingMultiChoices.isNotEmpty) {
              userPickMessage.add({
                "message": messages.last["message"],
                if (messages.last["goal"] != null)
                  "goal": messages.last["goal"],
                "userResponse": upperResponse,
              });

              String item = _pendingMultiChoices.removeAt(0);
              if (_pendingMultiChoices.isEmpty) {
                messageIndex++;
              }
              isAdded = true;
              messages.add({
                "goal": ["loan"],
                "type": "input",
                "message": '현재 보유 중인 ' '$item 대출' ' 금액이 얼마인가요?',
                "message-hint": "(만원 단위)",
                "options": [
                  "1000",
                  "2500",
                  "3000",
                  "5000",
                ],
              });
            }
          }
        }
      });
    }

    if (isAdded) {
      isAdded = false;
    } else if (currentQuestionIndex < totalQuestions) {
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
      print(userAnswerMap);
      context.go(
        '${RouteConst.chatBotResultFinance}?category=$category',
        extra: {
          'scoreList': calculateFinanceScore(userAnswerMap, questionList),
          'userAnswer': userAnswerMap,
        },
      );
      return;
    }
    userAnswerMap = extractUserAnswerMap(userPickMessage);
    isResultDisplayed = true;
    messages.add({
      "type": "choice",
      "options": ["결과 보러가기"],
      "message": """
재테크 현황 분석이 완료되었습니다.

${userPickMessage.map((userPick) => "• ${userPick["message"]}\n➡️ ${userPick["userResponse"]}").join("\n\n")}
      """,
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
    // 로딩중에는 로딩 인디케이터를 표시합니다.
    if (_isLoading) {
      return Scaffold(
        appBar: CommonAppBar(
          title: getCategoryGroup(category),
          useAppHome: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CommonAppBar(
        title: getCategoryGroup(category),
        useAppHome: true,
      ),
      body: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
                begin: 0.0,
                end: totalQuestions > 0
                    ? currentQuestionIndex / totalQuestions
                    : 0.0),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                backgroundColor: MyColors.lightGrey,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(MyColors.mainColor),
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
                          key: ValueKey(message),
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
