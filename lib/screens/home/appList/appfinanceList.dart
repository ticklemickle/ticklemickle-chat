import 'package:ticklemickle_m/common/utils/const.dart';

Map<String, dynamic> getCategoryObject(String category) {
  final result = appfinanceList.firstWhere(
    (element) => element["category"] == category,
  );
  return result;
}

String getCategoryGroup(String category) {
  final String group = getCategoryObject(category)["group"];
  String title = getCategoryObject(category)["title"];
  title = title.split(' ')[0];
  final String result = group == "propensity"
      ? " 성향 분석"
      : group == "knowledge"
          ? " 지식 테스트"
          : " 성향 분석";

  return title + result;
}

final List<Map<String, dynamic>> appfinanceList = [
  {
    "group": "basic",
    "category": CategoryConst.questionsBasicStatus,
    "title": "재테크 현황",
    "subtitle": "2025년 최신판",
    "image": "money.png",
    "participants": 35
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsKoreaStockInvestment,
    "title": "국내주식 투자",
    "image": "stockGraph.png",
    "participants": 12
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsUSAStockInvestment,
    "title": "미국주식 투자",
    "image": "usStock.png",
    "participants": 5
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsRealEstateCommercial,
    "title": "부동산 (상가) 투자",
    "image": "building.png",
    "participants": 35
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsRealEstateResidential,
    "title": "부동산 (주택) 투자",
    "image": "house.png",
    "participants": 325
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsCrypto,
    "title": "코인 투자",
    "image": "bitcoin.png",
    "participants": 35
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsLookalike,
    "title": "금융 닮은꼴 찾기",
    "image": "happyface.png",
    "participants": 3675
  },
  {
    "group": "propensity",
    "category": CategoryConst.questionsStableInvestor,
    "title": "안정적인 투자자",
    "image": "bank.png",
    "participants": 75
  },
  {
    "group": "knowledge",
    "category": CategoryConst.questionsTaxes,
    "title": "세금 (절세, 연말정산)",
    "image": "tax.png",
    "participants": 5
  },
  {
    "group": "knowledge",
    "category": CategoryConst.questionsLoans,
    "title": "대출",
    "image": "loan.png",
    "participants": 15
  },
  {
    "group": "knowledge",
    "category": CategoryConst.questionsFinancialHistory,
    "title": "금융 역사",
    "image": "history.png",
    "participants": 75
  },
];
