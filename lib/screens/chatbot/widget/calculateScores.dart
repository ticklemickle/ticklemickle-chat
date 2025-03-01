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

  if (question["type"] == "choice") {
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
