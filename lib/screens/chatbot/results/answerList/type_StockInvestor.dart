import 'package:ticklemickle_m/common/model/jsonToFinanceCommon.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/common_answerList.dart';

// Helper: 각 값에 대해 Low, Medium, High 범주를 반환하는 함수
bool isLow(double value) => value < 3;
bool isMedium(double value) => value >= 3 && value < 3;
bool isHigh(double value) => value >= 3;

String getInvestorType({
  required double aggression,
  required double ret,
  required double period,
  required double knowledge,
  required double amount,
}) {
  // 1. 특수 조건 우선 체크 (세분화된 범주 기준)

  // 단기 투기 투자자: 투자기간이 매우 짧고, 공격성과 기대수익이 높을 때
  if (period < 2.0 && isHigh(aggression) && isHigh(ret)) {
    return '단기 투기 투자자';
  }

  // 장기 가치 투자자: 투자기간이 매우 길고(4 이상) 기대수익이 낮은 경우
  if (period > 4.0 && ret < 3.0) {
    return '장기 가치 투자자';
  }

  // 공격적 수익 추구 투자자: 공격성과 기대수익이 매우 높은 경우 (4.5 이상)
  if (aggression > 4.5 && ret > 4.5) {
    return '공격적 수익 추구 투자자';
  }

  // 시장 타이밍 투자자: 투자기간이 짧은(2.5 미만)데다, 공격성과 투자지식이 높을 때
  if (period < 2.5 && aggression > 4.0 && knowledge > 4.0) {
    return '시장 타이밍 투자자';
  }

  // 리스크 헷지 투자자: 투자지식이 높으면서 공격성이 낮은 경우
  if (knowledge > 4.0 && aggression < 2.5) {
    return '리스크 헷지 투자자';
  }

  // 혁신 기술 투자자: 기대수익과 투자지식이 높으면서도 공격성이 극단적이지 않은 경우
  if (ret > 4.0 && knowledge > 4.0 && aggression <= 4.0) {
    return '혁신 기술 투자자';
  }

  // 고액 투자자: 투자금액이 매우 높은 경우
  if (amount > 4.0) {
    return '고액 투자자';
  }

  // 전문 전략 투자자: 투자지식이 높은데 (4 이상) 공격성과 기대수익은 중간 범위일 때
  if (knowledge > 4.0 &&
      aggression >= 2 &&
      aggression <= 4.0 &&
      ret >= 2 &&
      ret <= 4.0) {
    return '전문 전략 투자자';
  }

  // 적극 성장 투자자: 공격성과 기대수익이 높으면서 투자기간이 중간 이상일 때
  if (isHigh(aggression) && isHigh(ret) && period >= 3.0) {
    return '적극 성장 투자자';
  }

  // 자산 집중 투자자: 투자금액이 높은데, 공격성과 기대수익, 투자기간이 낮은 경우
  if (amount > 3.5 && aggression < 3.0 && ret < 3.0 && period < 3.0) {
    return '자산 집중 투자자';
  }

  // 분산 투자자: 투자금액이 낮은 경우
  if (isLow(amount)) {
    return '분산 투자자';
  }

  // 2. 위의 조건에 해당되지 않는 경우, 전체 점수 합계를 기준으로 보수/안정/균형 투자자로 매핑
  double total = aggression + ret + period + knowledge + amount;
  // 전체 점수 범위: 최소 5, 최대 25
  if (total < 12) {
    return '보수형 투자자';
  } else if (total < 16) {
    return '안정형 투자자';
  } else {
    return '균형 투자자';
  }
}

/// 입력 점수와 투자자 유형에 따른 랜덤 궁합 점수를 함께 반환하는 함수
JsonToResult mapInvestorResult({
  required double aggression,
  required double ret,
  required double period,
  required double knowledge,
  required double amount,
}) {
  final investorType = getInvestorType(
    aggression: aggression,
    ret: ret,
    period: period,
    knowledge: knowledge,
    amount: amount,
  );
  print(investorType);
  return findStockBySub(investorType);
}

JsonToResult findStockBySub(String sub) {
  return commonStockList.firstWhere(
    (stock) => stock.sub == sub,
  );
}
