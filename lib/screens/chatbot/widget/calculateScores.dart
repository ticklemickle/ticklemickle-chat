Map<String, double> getUserScore(Map<String, dynamic> question,
    String userAnswer, Map<String, double> rawScores) {
  double questionScore = 0;

  if (question["type"] == "choice") {
    List<dynamic> options = question["options"];
    int selectedIndex = options.indexWhere((option) => option == userAnswer);
    questionScore = selectedIndex + 1;
  } else if (question["type"] == "ox") {
    questionScore = (userAnswer == question["answer"]) ? 3 : 0;
  }

  // 질문에 할당된 모든 goal 항목에 대해 점수 누적
  List<dynamic> goals = question["goal"];
  for (String goal in goals) {
    if (rawScores.containsKey(goal)) {
      rawScores[goal] = rawScores[goal]! + questionScore;
    }
  }
  return rawScores;
}

Map<String, Map<String, double>> getQuestionRange(Map<String, dynamic> question,
    Map<String, Map<String, double>> scoreRange) {
  double maxScore = 0;
  double minScore = 0;

  if (question["type"] == "choice" || question["type"] == "input") {
    List<dynamic> options = question["options"];
    maxScore = (options.length).toDouble();
    minScore = 1;
  } else if (question["type"] == "ox") {
    maxScore = 3;
    minScore = 0;
  }

  // 각 goal 항목에 대해 누적해서 최대/최소값을 더함
  List<dynamic> goals = question["goal"];
  for (var goal in goals) {
    if (scoreRange.containsKey(goal)) {
      scoreRange[goal]!["max"] = scoreRange[goal]!["max"]! + maxScore;
      scoreRange[goal]!["min"] = scoreRange[goal]!["min"]! + minScore;
    }
  }
  return scoreRange;
}

List<double> scaleScores(
    Map<String, double> myscore, Map<String, Map<String, double>> scoreRange) {
  List<double> scaledScores = [];

  myscore.forEach((key, value) {
    double min = scoreRange[key]?["min"] ?? 0;
    double max = scoreRange[key]?["max"] ?? 1; // max가 1보다 작아지지 않도록 설정

    if (min == max) {
      scaledScores.add(3.0); // min과 max가 같으면 중간값 반환
    } else {
      double scaledValue = 1 + (value - min) * 4 / (max - min);
      scaledScores.add(scaledValue);
    }
  });

  return scaledScores;
}

///////////////////
/* basic chatbot */
int convertMoneyToManWon(String moneyStr) {
  // 공백, 콤마 제거
  moneyStr = moneyStr.trim().replaceAll(",", "").replaceAll(" ", "");
  int total = 0;

  if (moneyStr.contains("억")) {
    // '억'을 기준으로 분할
    List<String> parts = moneyStr.split("억");
    // 억 단위 부분 처리 (예: "9" → 9 * 10000)
    int billionPart = int.tryParse(parts[0]) ?? 0;
    total += billionPart * 10000;
    // 만원 단위가 뒤에 있는 경우 처리 (예: "8765만원")
    if (parts.length > 1 && parts[1].contains("만원")) {
      String manPart = parts[1].replaceAll("만원", "");
      int manValue = int.tryParse(manPart) ?? 0;
      total += manValue;
    }
    return total;
  } else if (moneyStr.contains("만원")) {
    String numberPart = moneyStr.replaceAll("만원", "");
    return int.tryParse(numberPart) ?? 0;
  } else {
    return int.tryParse(moneyStr) ?? 0;
  }
}

int getInputValue(String input) {
  if (input.contains("만원") || input.contains("억원")) {
    return convertMoneyToManWon(input);
  } else {
    return int.tryParse(input.replaceAll(",", "")) ?? 0;
  }
}

int calculateScoreFromThresholds(List<String> options, String userInput) {
  int inputValue = getInputValue(userInput);
  // options를 double 리스트로 변환합니다.
  List<double> thresholds = options
      .map((option) => double.tryParse(option.replaceAll(",", "")) ?? 0)
      .toList();

  if (inputValue <= thresholds[0]) {
    return 1;
  } else if (inputValue <= thresholds[1]) {
    return 2;
  } else if (inputValue <= thresholds[2]) {
    return 3;
  } else if (inputValue <= thresholds[3]) {
    return 4;
  } else {
    return 5;
  }
}

Map<String, double> updateUserScores(Map<String, dynamic> question,
    String userInput, Map<String, double> userScores) {
  int score = calculateScoreFromThresholds(question["options"], userInput);
  // goal 리스트 내의 각 문자열을 ','로 분리하여 실제 key 목록을 구성합니다.
  List<String> goals = [];
  for (var g in question["goal"]) {
    if (g.contains(",")) {
      goals.addAll(g.split(',').map((s) => s.trim()));
    } else {
      goals.add(g.trim());
    }
  }
  // 해당 goal에 해당하는 userScore 항목에 점수를 누적합니다.
  for (var key in goals) {
    if (userScores.containsKey(key)) {
      userScores[key] = userScores[key]! + score;
    }
  }
  return userScores;
}

///////////////////
/* basic chatbot: mapping */
Map<String, int> extractUserAnswerMap(
    List<Map<String, dynamic>> userPickMessage) {
  Map<String, int> userAnswerMap = {};

  for (var message in userPickMessage) {
    if (message.containsKey("goal") && message["goal"] != null) {
      // goal은 리스트 형태라고 가정합니다.
      List<dynamic> goals = message["goal"];
      // userResponse 값을 문자열로 변환 후 숫자로 변환합니다.
      String userResponseStr = message["userResponse"].toString();
      int value = getInputValue(userResponseStr);

      for (var goal in goals) {
        String goalKey = goal.toString();
        if (goalKey == "loan") {
          // "loan"은 여러 건이 있을 수 있으므로 누적합을 구합니다.
          userAnswerMap[goalKey] = (userAnswerMap[goalKey] ?? 0) + value;
        } else {
          // 그 외의 goal은 단일 값으로 세팅합니다.
          userAnswerMap[goalKey] = value;
        }
      }
    }
  }
  return userAnswerMap;
}
