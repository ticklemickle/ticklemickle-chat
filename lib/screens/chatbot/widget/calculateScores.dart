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
      int value = convertMoneyToManWon(userResponseStr);

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

Map<String, double> calculateFinanceScore(
  Map<String, int> userAnswer,
  List<Map<String, dynamic>> questions,
) {
  final scores = Map.fromEntries(
    questions
        .where((question) =>
            question.containsKey('goal') &&
            question['goal'] is List &&
            question['goal'].isNotEmpty &&
            question.containsKey('options'))
        .map((question) {
      // goal 리스트에서 첫 번째 키 사용
      String key = question['goal'][0];
      List<int> thresholds = (question['options'] as List)
          .map((option) => int.parse(option.toString()))
          .toList();

      int value = userAnswer[key] ?? 0;
      double score = 1;

      if (value <= thresholds[0]) {
        score = key == "spend" ? 5.0 : 1; // 소비(spend)일 경우 반대로 적용
      } else if (value >= thresholds[3]) {
        score = key == "spend" ? 1 : 5.0; // 소비(spend)일 경우 반대로 적용
      } else {
        // 비율 기반 점수 계산
        for (int i = 0; i < thresholds.length - 1; i++) {
          if (value <= thresholds[i + 1]) {
            double ratio =
                (value - thresholds[i]) / (thresholds[i + 1] - thresholds[i]);
            score = (i + 1) + ratio; // 기본 점수 + 비율 보정
            // 소비(spend)일 경우 반대로 변환
            if (key == "spend") {
              score = 5.5 - score;
            }
          }
        }
      }
      return MapEntry(key, double.parse(score.toStringAsFixed(2)));
    }),
  );
  scores['loan'] = calculateLoanScore(userAnswer);
  return scores;
}

double calculateLoanScore(Map<String, int> userAnswer) {
  int loan = userAnswer['loan'] ?? 0;
  int assets = userAnswer['assets'] ?? 0;

  if (loan == 0) return 5.0; // 부채가 없으면 최고 점수 반환
  double ratio = loan / (assets + loan); // 부채 비율 계산
  double score = 5.0 - ratio * 4.0; // 비율을 반대로 적용하여 5~1 범위로 변환

  return double.parse(score.toStringAsFixed(2)); // 소수점 2자리 제한
}

Map<String, int> getMedianValues(List<Map<String, dynamic>> questions) {
  Map<String, int> result = {};

  for (var question in questions) {
    if (question.containsKey('goal') && question.containsKey('options')) {
      List<String> goals = List<String>.from(question['goal']); // goal 리스트 추출
      List<int> options = (question['options'] as List)
          .map((option) => int.parse(option.toString()))
          .toList();

      if (options.isEmpty) continue; // options가 비어있으면 건너뛰기

      options.sort(); // 정렬

      int median;
      int length = options.length;

      if (length % 2 == 1) {
        median = options[length ~/ 2]; // 홀수 개면 가운데 값
      } else {
        median = (options[length ~/ 2 - 1] + options[length ~/ 2]) ~/
            2; // 짝수 개면 두 개 평균 (정수)
      }

      for (var goal in goals) {
        result[goal] = median; // 각 goal에 대해 중간값 저장
      }
    }
  }

  return result;
}
