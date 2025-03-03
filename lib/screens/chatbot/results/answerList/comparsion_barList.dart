// 4개의 예시 데이터
import 'package:ticklemickle_m/common/model/comparsionChart.dart';
import 'package:ticklemickle_m/common/utils/StringUtil.dart';

List<ComparisonData> updateChartDataList(Map<String, int> newValues) {
  return chartDataList.map((data) {
    String key;
    switch (data.title) {
      case '소득':
        key = 'income';
        break;
      case '자산':
        key = 'assets';
        break;
      case '소비':
        key = 'spend';
        break;
      case '저축 규모':
        key = 'saved';
        break;
      default:
        key = '';
    }

    // newValues에 해당 key가 없으면 기존 myValue를 사용합니다.
    final newMyValue = newValues[key] ?? data.myValue;
    // 단위 등 추가 포맷팅이 필요하면 아래에서 수정할 수 있습니다.
    final newMyLabel = formatAmount(newMyValue.toString());

    return ComparisonData(
      title: data.title,
      averageValue: data.averageValue,
      myValue: newMyValue,
      averageLabel: data.averageLabel,
      myLabel: newMyLabel,
    );
  }).toList();
}

final chartDataList = [
  const ComparisonData(
    title: '소득',
    averageValue: 4805,
    myValue: 0,
    averageLabel: '0원',
    myLabel: '0원',
  ),
  const ComparisonData(
    title: '자산',
    averageValue: 37000,
    myValue: 0,
    averageLabel: '0원',
    myLabel: '0원',
  ),
  const ComparisonData(
    title: '소비',
    averageValue: 105,
    myValue: 0,
    averageLabel: '0원',
    myLabel: '0원',
  ),
  const ComparisonData(
    title: '저축 규모',
    averageValue: 10000,
    myValue: 0,
    averageLabel: '0원',
    myLabel: '0원',
  ),
];
