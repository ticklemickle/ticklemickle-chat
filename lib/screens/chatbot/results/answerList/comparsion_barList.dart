import 'package:ticklemickle_m/common/model/comparsionChart.dart';
import 'package:ticklemickle_m/common/utils/StringUtil.dart';

List<ComparisonData> updateChartDataList(
    Map<String, int> averageValue, Map<String, int> myValue) {
  const titleToKey = {
    '자산': 'assets',
    '월 소비': 'spend',
    '총 저축': 'saved',
    '소득': 'income',
  };

  return chartDataList.map((data) {
    final key = titleToKey[data.title] ?? '';
    final newAverageValue = averageValue[key] ?? data.averageValue;
    final newMyValue = myValue[key] ?? data.myValue;

    return ComparisonData(
      title: data.title,
      averageValue: newAverageValue,
      myValue: newMyValue,
      averageLabel: formatAmount(newAverageValue.toString()),
      myLabel: formatAmount(newMyValue.toString()),
    );
  }).toList();
}

final chartDataList = ['자산', '월 소비', '총 저축', '소득']
    .map((title) => ComparisonData(
          title: title,
          averageValue: 999,
          myValue: 0,
          averageLabel: '0원',
          myLabel: '0원',
        ))
    .toList();

List<double> convertScoreList(
  Map<String, double> scoreList,
  List<String> labels,
) {
  // 한글 label과 영어 key의 매핑 (필요에 따라 확장 가능)
  final Map<String, String> korToEng = {
    '자산': 'assets',
    '소비': 'spend',
    '부채': 'loan',
    '저축': 'saved',
    '소득': 'income',
  };

  return labels.map((label) {
    // 각 한글 label에 해당하는 영어 key를 가져오고,
    // scoreList에 해당 key가 없으면 기본값 0을 사용합니다.
    String engKey = korToEng[label] ?? '';
    return scoreList[engKey] ?? 0;
  }).toList();
}
