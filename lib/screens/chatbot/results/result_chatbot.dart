import 'package:ticklemickle_m/common/model/lookalike.dart';

const freeTitle = "재테크 단톡방 참여하기";
const freeDetail = "200명 미만 무료";
const freeImagePath = "assets/chatbot/result/common/free_card.png";

const groupTitle = "한국의 재테크 고수 모임";
const groupDetail = "20명 미만, 실명, 비대면";
const groupImagePath = "assets/chatbot/result/common/group_card.png";

const vipTitle = "투자 레벨이 맞는 맞춤형 모임";
const vipDetail = "10명 미만, 실명, 오프라인 스터디";
const vipImagePath = "assets/chatbot/result/common/vip_card.png";

final List<Lookalike> lookalikeList = [
  Lookalike.fromJson({
    "name": "철수 버핏",
    "image": "assets/chatbot/result/lookalike/warren_buffett.png",
    "match": "회귀성 16%",
    "description": "'10년 이상 보유하지 않으면 단 10분도 보유하지 마라'라는 명언으로도 유명한 투자자!\n"
        "당신은 정말 현명한 투자자인 것 같아요.\n\n"
        "가치투자의 대가인 워렌버핏과 매우 닮았습니다. 항공사, 카지노, 백화점 등에 대한 섹터와 어울리며,"
        "저평가된 기업을 면밀히 분석하여 장기 투자하는 것이 매우 적합합니다.",
    "links": [
      {"title": freeTitle, "detail": freeDetail, "imagePath": freeImagePath},
      {
        "title": "한국의 워렌 버핏 모임",
        "detail": groupDetail,
        "imagePath": groupImagePath
      },
      {"title": vipTitle, "detail": vipDetail, "imagePath": vipImagePath},
    ]
  }),
  Lookalike.fromJson({
    "name": "영희 게이츠",
    "image": "assets/chatbot/result/lookalike/bill_gates.png",
    "match": "독창성 56%",
    "description": "당신의 투자 성향은 옳은 곳에 투자하고 올바른 길을 걷는 빌게이츠와 닮았네요\n"
        "투자에 대한 학구열이 높고 꼼꼼히 학습하는 습관은 결국 당신을 부자로 만들어주게 되겠네요.\n"
        "추천드리는 투자 섹터는 반도체, 2차전지, IT 등이 있으며 뛰어난 시장성을 갖은 섹터를 찾아 기업을 분석하는 TOP DOWN 방식이 어울리는 투자자 입니다.",
    "links": [
      {"title": freeTitle, "detail": freeDetail, "imagePath": freeImagePath},
      {
        "title": "한국의 빌 게이츠 모임",
        "detail": groupDetail,
        "imagePath": groupImagePath
      },
      {"title": vipTitle, "detail": vipDetail, "imagePath": vipImagePath},
    ]
  }),
  Lookalike.fromJson({
    "name": "명수 머스크",
    "image": "assets/chatbot/result/lookalike/elon_musk.png",
    "match": "독창성 56%",
    "description": "당신의 자유로움과 대담한 도전정신은 테슬라의 대표 일론 머스크와 닮았네요!\n"
        "매우 젊은 나이부터 백만장자가 되고 남들이 생각하지 않는 기발한 생각을 갖고 있는 당신은 향후 뛰어난 성공한 투자자가 될 수 있어보여요!\n"
        "당신과 어울리는 투자 섹터는 태양광, 풍력, 우주산업 등이 있으며 환경, 사회, 지배구조를 고려하여 투자하는 ESG 투자 방식이 어울리는 투자자 입니다.",
    "links": [
      {"title": freeTitle, "detail": freeDetail, "imagePath": freeImagePath},
      {
        "title": "한국의 일론 머스크 모임",
        "detail": groupDetail,
        "imagePath": groupImagePath
      },
      {"title": vipTitle, "detail": vipDetail, "imagePath": vipImagePath},
    ]
  }),
];
