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

class ChatBotBasic extends StatefulWidget {
  final String category;

  const ChatBotBasic({Key? key, required this.category}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotBasic> {
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

  Map<String, int> userAnswerMap = {
    "income": 0,
    "assets": 0,
    "spend": 0,
    "saved": 0,
  };

  Map<String, double> userScores = {
    "assets": 0,
    "spend": 0,
    "loan": 0,
    "saved": 0,
    "income": 0,
  };
  Map<String, Map<String, double>> scoreRange = {
    "assets": {"max": 0.0, "min": 0.0},
    "spend": {"max": 0.0, "min": 0.0},
    "loan": {"max": 0.0, "min": 0.0},
    "saved": {"max": 0.0, "min": 0.0},
    "income": {"max": 0.0, "min": 0.0},
  };

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
            messages[messageIndex - 1]["type"] != "basic") {
          userPickMessage.add({
            "message": messages.last["message"],
            "goal": messages.last["goal"],
            "userResponse": upperResponse,
          });
        }
        if (messages[messageIndex - 1]["type"] == "input") {
          //type: choice, input
          userScores = updateUserScores(
              messages[messageIndex - 1], userResponse, userScores);
          scoreRange = getQuestionRange(messages[messageIndex - 1], scoreRange);
        }

        if (messages[messageIndex - 1]["type"] == "multi-choice") {
          if (_pendingMultiChoices.isEmpty) {
            _pendingMultiChoices =
                userResponse.split(',').map((item) => item.trim()).toList();
          }
          if (_pendingMultiChoices.isNotEmpty) {
            userPickMessage.add({
              "message": messages.last["message"],
              if (messages.last["goal"] != null) "goal": messages.last["goal"],
              "userResponse": upperResponse,
            });

            String item = _pendingMultiChoices.removeAt(0);
            if (_pendingMultiChoices.isEmpty) {
              messageIndex++;
            } else {}
            isAdded = true;
            messages.add({
              "goal": ["loan"],
              "type": "choice",
              "message": '$item 대출 보유 금액이 얼마인지 알려주세요.',
              "options": [
                "100만원",
                "200만원",
                "300만원",
                "500만원",
              ],
            });
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
      context.go(
        '${RouteConst.chatBotResultBasic}?category=$category',
        extra: {
          'scoreList': scaleScores(userScores, scoreRange),
          'userAnswer': userAnswerMap,
        },
      );
      return;
    }
    userAnswerMap = extractUserAnswerMap(userPickMessage);
    // print(userPickMessage);/
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
    return Scaffold(
      appBar: CommonAppBar(
        title: getCategoryGroup(category),
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
