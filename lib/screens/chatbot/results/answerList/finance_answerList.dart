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

Map<String, String> matchFinancialType(Map<String, double> scores) {
  double income = scores["income"] ?? 0;
  double saved = scores["saved"] ?? 0;
  double spend = scores["spend"] ?? 0;
  double assets = scores["assets"] ?? 0;
  double loan = scores["loan"] ?? 0;

  String type;
  String strength;
  String weakness;

  if (income >= 3.5 && assets >= 3.5 && saved >= 3.5 || loan >= 3.5) {
    type = "재정적 자유형";
    strength =
        "높은 소득, 자산, 저축 수준을 바탕으로 다양한 투자와 소비 선택의 폭이 넓으며, 금융 자립을 이루기 위한 안정적인 기반이 마련되어 있습니다. 이러한 재정 상태는 미래에 새로운 투자 기회와 자산 증대의 가능성을 제공하며, 경제적 자유를 바탕으로 보다 혁신적인 금융 전략을 도입할 수 있는 큰 잠재력을 내포하고 있습니다.";
    weakness =
        "현재의 안정된 재정 상태에도 불구하고, 예상치 못한 시장 변동이나 경제 위기 상황에 대비한 리스크 관리 체계가 다소 미흡할 수 있습니다. 추가적으로, 자산 증대와 투자 다각화를 위한 보다 적극적인 전략 수립이 필요하며, 금융 환경의 급격한 변화에 유의해야 합니다.";
  } else if (income >= 3 && assets >= 3 && saved >= 3 && spend <= 3 ||
      loan >= 2) {
    type = "안정적 중산층";
    strength =
        "적절한 수준의 소득과 자산, 그리고 꾸준한 저축 습관을 통해 현재 안정적인 생활을 유지하고 있으며, 균형 잡힌 금융 습관으로 미래에 더 나은 재정적 기반을 마련할 가능성이 높습니다. 안정된 생활 속에서 점진적인 개선과 투자 여력을 발휘할 수 있는 토대를 마련하고 있습니다.";
    weakness =
        "비록 현재 안정된 재정 상태를 유지하고 있으나, 글로벌 경제 변동이나 예기치 못한 비용 증가에 대비한 체계적인 투자 전략과 저축 계획의 보완이 요구됩니다. 장기적인 재정 안정을 위해 추가적인 위험 분산 및 자산 배분 전략에 대한 재검토가 필요합니다.";
  } else if (income <= 2.5 && saved <= 2.5 && assets <= 2.5 || loan <= 2.5) {
    type = "재정 위험층";
    strength =
        "현재 재정 상황은 어려움을 겪고 있으나, 소득 개선과 비용 절감, 부채 상환을 위한 구체적인 계획을 마련한다면 점진적으로 재정 구조를 개선할 수 있는 잠재력이 존재합니다. 정부 지원이나 외부 금융 지원 등 다양한 기회를 활용할 가능성이 있습니다.";
    weakness =
        "낮은 소득, 미흡한 저축 및 제한된 자산 규모로 인해 재정 건전성이 매우 취약하며, 예상치 못한 경제적 충격에 쉽게 노출될 위험이 큽니다. 단기적인 소비 통제와 긴급 자금 마련, 체계적인 재정 구조 개선이 시급한 유의점입니다.";
  } else if (income >= 3 && spend <= 2.5 && saved <= 2.5 || loan <= 2.5) {
    type = "과소비 위험층";
    strength =
        "현재 일정 수준의 소득이 확보되어 단기적으로는 소비 활동에 여력이 있으나, 소비 패턴의 개선과 체계적인 재정 관리가 이루어진다면 미래에는 보다 안정적이고 건강한 금융 상태를 도모할 가능성이 있습니다. 소비 통제와 저축 확대를 통해 여유 자금을 투자로 전환할 기회가 있습니다.";
    weakness =
        "당장의 소비 욕구 충족에 치중한 결과, 저축과 투자에 할당되는 자원이 부족하여 장기적인 재정 안정성이 위협받을 수 있습니다. 소비 습관의 재점검, 예산 관리의 체계적 개선, 그리고 긴급 상황에 대비한 자금 확보 전략이 필수적으로 요구됩니다.";
  } else if (income >= 3 && assets >= 3 || loan <= 2) {
    type = "부채 과다 자산형";
    strength =
        "보유 자산이 일정 수준 이상임을 바탕으로, 부채 상환 및 자산 재구성을 통해 순자산 개선의 가능성이 존재합니다. 자산의 유동화 및 재투자 전략을 통해 향후 재정 건전성을 더욱 강화할 잠재력이 있습니다.";
    weakness =
        "높은 부채 비율은 금융 비용 증가와 신용 하락 등 다양한 위험 요소로 작용할 수 있으며, 전반적인 재정 건전성을 저해할 수 있습니다. 체계적인 부채 상환 계획 수립과 금융 리스크 관리 전략이 반드시 필요하며, 부채 관리를 소홀히 할 경우 장기적인 재정 악화가 우려됩니다.";
  } else if (income >= 3.5 && spend >= 3 && saved >= 3.5) {
    type = "절약형 자산가";
    strength =
        "높은 소득과 꾸준한 저축 습관을 바탕으로 단기 및 장기적 자산 증대에 유리한 재정 기반을 마련하고 있습니다. 안정적인 금융 습관은 경제 상황 변화에도 비교적 탄력적으로 대응할 수 있으며, 미래에는 보다 적극적인 투자와 자산 배분 전략을 통해 재정적 성장을 도모할 큰 가능성이 있습니다.";
    weakness =
        "현재는 안정적인 자산 축적에 집중하고 있으나, 상대적으로 제한적인 소비 패턴으로 인해 유망한 투자 기회를 충분히 활용하지 못할 위험이 있습니다. 투자 다각화와 시장 동향에 대한 지속적인 모니터링, 그리고 단기 소비 패턴 변화에 대한 주의가 필요합니다.";
  } else if (income <= 1.5 && saved <= 1.5) {
    type = "무소득 무저축형";
    strength =
        "현재 안정적인 소득과 저축이 부족하더라도, 정부 지원금이나 가족 및 사회적 지원을 통해 기본적인 생계 유지는 가능하며, 만약 외부 지원과 자기 개발을 통해 소득원을 다각화한다면 재정 자립을 모색할 가능성이 존재합니다.";
    weakness =
        "지속적인 소득 부재와 미흡한 저축 습관은 장기적으로 재정적 불안정성을 초래할 위험이 크며, 부채 누적 및 신용 하락 등의 심각한 경제적 문제로 이어질 수 있습니다. 따라서 소득 창출 방안 마련과 소비 통제, 긴급 자금 마련 등 재정 관리에 더욱 유의해야 합니다.";
  } else if (spend <= 1.5 && loan <= 1.2) {
    type = "과소비 부채형";
    strength =
        "현재 단기적으로 높은 소비 활동을 유지할 수 있는 능력을 보유하고 있으며, 이를 통해 생활의 질을 빠르게 향상시킬 수 있는 잠재력이 있습니다. 시장 상황에 따라 소비 여력을 조절할 수 있는 유연성을 갖추고 있습니다.";
    weakness =
        "소득 대비 과도한 소비와 부채 의존은 장기적으로 재정 악화를 초래할 위험이 크며, 이자 부담과 부채 증가로 인해 미래의 재정 건전성이 크게 위협받을 수 있습니다. 소비 관리와 체계적인 재정 계획 수립에 대한 면밀한 검토가 필요합니다.";
  } else {
    type = "평균 일반형";
    strength =
        "일상적인 소비, 저축, 그리고 자산 관리에 있어서 특별한 문제 없이 안정적인 재정 상태를 유지하고 있으며, 기본적인 금융 지식과 습관을 바탕으로 향후 개선과 성장이 가능할 수 있는 충분한 기반을 마련하고 있습니다.";
    weakness =
        "특별히 두드러진 강점이 부각되지 않아, 예상치 못한 경제적 위기나 외부 충격에 취약할 수 있습니다. 지속적인 금융 환경 변화에 맞추어 재정 전략을 보완하고 다각화할 필요가 있으며, 장기적인 안정을 위해 주의 깊은 재정 관리가 요구됩니다.";
  }

  return {"type": type, "strength": strength, "weakness": weakness};
}
