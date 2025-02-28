List<Map<String, dynamic>> getQuestionsList(String category) {
  switch (category) {
    case 'Questions_InvestmentStatus':
      return Questions_InvestmentStatus;
    case 'Questions_KoreaStockInvestment':
      return Questions_KoreaStockInvestment;
    case 'Questions_USAStockInvestment':
      return Questions_USAStockInvestment;
    case 'Questions_RealEstateCommercial':
      return Questions_RealEstateCommercial;
    case 'Questions_RealEstateResidential':
      return Questions_RealEstateResidential;
    case 'Questions_Crypto':
      return Questions_Crypto;
    case 'Questions_StableInvestor':
      return Questions_StableInvestor;
    case 'Questions_Taxes':
      return Questions_Taxes;
    case 'Questions_Loans':
      return Questions_Loans;
    case 'Questions_FinancialHistory':
      return Questions_FinancialHistory;
    default:
      return Questions_InvestmentStatus;
  }
}

const List<Map<String, dynamic>> Questions_InvestmentStatus = [
  {"type": "text", "message": "안녕하세요. 금융 지식 테스트를 시작하겠습니다!"},
  {
    "type": "choice",
    "message": "먼저 저희쪽에 등록한 정보가 맞는지 확인해주세요. 아래 정보가 맞나요?\n\n1990년생 남성",
    "options": ["맞아요", "변경하기"]
  },
  {"type": "ox", "message": "은행에 돈을 예금하면 시간이 지날수록 가치가 올라간다.", "answer": "x"},
  {
    "type": "choice",
    "message": "1년 정기 예금 100만원, 연 2% 이자라면 1년 뒤 이자는?",
    "options": ["2만원", "2만원 이하", "2만원 이상"],
    "answer": "2만원"
  },
  {
    "type": "choice",
    "message": "미국에서 기준 금리를 결정하는 기관은?",
    "options": ["WTO", "FTA", "FED", "WHO"],
    "answer": "FED"
  },
  {"type": "ox", "message": "비트코인은 중앙은행이 발행하는 디지털 화폐이다.", "answer": "x"}
];
// 국내 주식 투자 지식 테스트
const List<Map<String, dynamic>> Questions_KoreaStockInvestment = [
  {"type": "text", "message": "안녕하세요. 국내 주식 투자 지식 테스트를 시작하겠습니다!"},
  {"type": "ox", "message": "주식은 기업의 지분을 나타내는 금융상품이다.", "answer": "o"},
  {
    "type": "choice",
    "message": "국내 코스피 시장에서 시가총액이 가장 큰 기업은?",
    "options": ["삼성전자", "현대차", "SK하이닉스", "LG에너지솔루션"],
    "answer": "삼성전자"
  },
  {
    "type": "choice",
    "message": "주식 투자 시 '분산 투자'의 주요 목적은 무엇일까요?",
    "options": ["수수료 절감", "위험 분산", "배당금 극대화", "기업 지분 확대"],
    "answer": "위험 분산"
  },
  {"type": "ox", "message": "코스닥 지수는 주로 대기업 중심으로 편성되어 있다.", "answer": "x"},
];

// 미국 주식 투자 지식 테스트
const List<Map<String, dynamic>> Questions_USAStockInvestment = [
  {"type": "text", "message": "안녕하세요. 미국 주식 투자 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "미국 주식 시장은 뉴욕증권거래소(NYSE)와 나스닥(NASDAQ)이 대표적이다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "다음 중 미국 나스닥(NASDAQ)에 상장된 대표 기술주는?",
    "options": ["마이크로소프트", "JP모건", "버크셔해서웨이", "엑슨모빌"],
    "answer": "마이크로소프트"
  },
  {
    "type": "choice",
    "message": "미국 주식 시장에서 'ETF'는 무엇의 약자일까요?",
    "options": [
      "Exchange Traded Fund",
      "Enhanced Trade Finance",
      "Electronic Trading Framework",
      "Equity Tax Fund"
    ],
    "answer": "Exchange Traded Fund"
  },
  {
    "type": "ox",
    "message": "미국 주식 투자 시 배당금에는 한국과 동일한 세율이 적용된다.",
    "answer": "x"
  },
];

// 상업용 부동산 지식 테스트
const List<Map<String, dynamic>> Questions_RealEstateCommercial = [
  {"type": "text", "message": "안녕하세요. 상업용 부동산 투자 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "상업용 부동산의 가치는 주로 임대료 수익과 시세 차익에 의해 결정된다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "상업용 부동산에서 가장 중요한 입지 요인 중 하나는?",
    "options": ["주변 학군", "교통 접근성", "인구 노령화", "주변 유흥 시설"],
    "answer": "교통 접근성"
  },
  {
    "type": "choice",
    "message": "임대차 계약 시 보증금 이외에 월세를 꾸준히 받을 수 있는 구조의 투자 형태를 무엇이라 할까요?",
    "options": ["전세 투자", "월세 투자", "공동 투자", "단기 임대"],
    "answer": "월세 투자"
  },
  {
    "type": "ox",
    "message": "오피스 빌딩, 리테일 쇼핑몰, 창고 등은 모두 상업용 부동산에 속한다.",
    "answer": "o"
  },
];

// 주거용 부동산 지식 테스트
const List<Map<String, dynamic>> Questions_RealEstateResidential = [
  {"type": "text", "message": "안녕하세요. 주거용 부동산 투자 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "주거용 부동산 투자 시 지역 인프라(교통, 교육 등)는 중요한 고려 요소이다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "주택 담보 대출을 받을 때 적용되는 개념으로, 주택 가격 대비 대출금의 비율을 의미하는 것은?",
    "options": ["DTI", "LTV", "DSR", "DPS"],
    "answer": "LTV"
  },
  {
    "type": "choice",
    "message": "다음 중 주거용 부동산 종류가 아닌 것은?",
    "options": ["아파트", "오피스텔", "단독주택", "공장 창고"],
    "answer": "공장 창고"
  },
  {
    "type": "ox",
    "message": "정부의 부동산 규제 정책은 주거용 부동산 시세에 직접적인 영향을 줄 수 있다.",
    "answer": "o"
  },
]; // 암호화폐(Crypto) 투자 지식 테스트
const List<Map<String, dynamic>> Questions_Crypto = [
  {"type": "text", "message": "안녕하세요. 암호화폐(Crypto) 투자 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "비트코인(Bitcoin)은 중앙은행이 통제하는 형태의 디지털 화폐이다.",
    "answer": "x"
  },
  {
    "type": "choice",
    "message": "이더리움(Ethereum)의 창시자는 누구인가?",
    "options": ["사토시 나카모토", "비탈릭 부테린", "찰리 리", "에이다(카르다노)"],
    "answer": "비탈릭 부테린"
  },
  {
    "type": "choice",
    "message": "다음 중 '스테이블코인(Stablecoin)'의 예시는?",
    "options": ["USDT", "BTC", "ETH", "XRP"],
    "answer": "USDT"
  },
  {
    "type": "ox",
    "message": "블록체인은 데이터가 중앙에 집중되어 한 곳에서만 관리되는 기술이다.",
    "answer": "x"
  },
];

// 안정적인 투자(Stable Investor) 지식 테스트
const List<Map<String, dynamic>> Questions_StableInvestor = [
  {
    "type": "text",
    "message": "안녕하세요. 안정적인 투자(Stable Investor) 지식 테스트를 시작하겠습니다!"
  },
  {
    "type": "ox",
    "message": "안정적인 투자는 높은 위험을 감수해 단기간에 수익을 극대화하는 방식이다.",
    "answer": "x"
  },
  {
    "type": "choice",
    "message": "다음 중 '안정적인 투자상품'으로 보기 어려운 것은?",
    "options": ["국채", "우량회사채", "정기 예금", "암호화폐"],
    "answer": "암호화폐"
  },
  {
    "type": "choice",
    "message": "장기 투자의 주요 장점으로 올바른 것은 무엇일까요?",
    "options": ["수수료 부담 증가", "변동성으로 인한 손실 극대화", "복리 효과", "시장 모니터링 불필요"],
    "answer": "복리 효과"
  },
  {
    "type": "ox",
    "message": "자산배분은 안정적인 투자 성향을 가진 사람들에게 중요한 전략이다.",
    "answer": "o"
  },
];

// 세금(Taxes) 지식 테스트
const List<Map<String, dynamic>> Questions_Taxes = [
  {"type": "text", "message": "안녕하세요. 세금(Taxes) 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "소득세(Income Tax)는 개인이 얻은 소득에 대해 부과되는 세금이다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "다음 중 한국의 '직접세'에 해당하는 것은?",
    "options": ["소득세", "부가가치세", "개별소비세", "증권거래세"],
    "answer": "소득세"
  },
  {
    "type": "choice",
    "message": "부동산 양도소득세는 어떤 소득에 부과되는 세금일까요?",
    "options": ["월세 소득", "전세 보증금", "부동산 매매 차익", "분양권 청약비"],
    "answer": "부동산 매매 차익"
  },
  {"type": "ox", "message": "납세 의무를 이행하지 않으면 법적 제재를 받을 수 있다.", "answer": "o"},
];

// 대출(Loans) 지식 테스트
const List<Map<String, dynamic>> Questions_Loans = [
  {"type": "text", "message": "안녕하세요. 대출(Loans) 지식 테스트를 시작하겠습니다!"},
  {
    "type": "ox",
    "message": "대출 이자율은 개인의 신용등급과 담보 등에 따라 달라질 수 있다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "다음 중 '담보 대출'이 아닌 것은?",
    "options": ["주택담보대출", "전세자금대출", "신용대출", "사업자 담보대출"],
    "answer": "신용대출"
  },
  {
    "type": "choice",
    "message": "대출을 고려할 때 중요하지 않은 요소는?",
    "options": ["금리", "상환능력", "대출 목적", "휴대전화 요금제"],
    "answer": "휴대전화 요금제"
  },
  {
    "type": "ox",
    "message": "원금 균등 분할 상환은 대출 기간 동안 매달 원금을 동일하게 갚는 방식이다.",
    "answer": "o"
  },
];

// 금융 역사(Financial History) 지식 테스트
const List<Map<String, dynamic>> Questions_FinancialHistory = [
  {
    "type": "text",
    "message": "안녕하세요. 금융 역사(Financial History) 지식 테스트를 시작하겠습니다!"
  },
  {
    "type": "ox",
    "message": "역사상 가장 오래된 화폐 형태 중 하나는 조개껍데기 화폐이다.",
    "answer": "o"
  },
  {
    "type": "choice",
    "message": "다음 중 1929년부터 시작된 경제 대공황 시기의 연도로 올바른 것은?",
    "options": ["1901년", "1929년", "1945년", "1971년"],
    "answer": "1929년"
  },
  {
    "type": "choice",
    "message": "브레튼우즈 체제 하에서 기축통화가 된 통화는 무엇일까요?",
    "options": ["미국 달러(USD)", "영국 파운드(GBP)", "프랑스 프랑(FRF)", "독일 마르크(DEM)"],
    "answer": "미국 달러(USD)"
  },
  {
    "type": "ox",
    "message": "세계 금융 시스템에서 금본위제는 현재도 대부분의 국가에서 적용 중이다.",
    "answer": "x"
  },
];
