const List<Map<String, dynamic>> financeBasicTest = [
  {"type": "text", "message": "안녕하세요. 금융 지식 테스트를 시작하겠습니다!"},
  {
    "type": "choice",
    "message": "먼저 저희쪽에 등록한 정보가 맞는지 확인해주세요. \n아래 정보가 맞나요?\n\n1990년생 남성",
    "options": ["맞아요", "변경하기"]
  },
  {"type": "ox", "message": "은행에 돈을 예금하면 시간이 지날수록 가치가 올라간다."},
  {
    "type": "choice",
    "message": "1년 정기 예금 100만원, 연 2% 이자라면 1년 뒤 이자는?",
    "options": ["2만원", "2만원 이하", "2만원 이상"]
  },
  {
    "type": "choice",
    "message": "미국에서 기준 금리를 결정하는 기관은?",
    "options": ["WTO", "FTA", "FED", "WHO"]
  },
  {
    "type": "choice",
    "message":
        "재테크 현황 분석이 완료되었습니다.\n아래 정보를 제출하겠습니다.\n\n• 1990년, 남성\n• 연소득: 1억 50만원\n• 월 평균 카드값: 325만원\n• 현재 보유 대출: 주택담보 대출, 예적금",
    "options": ["위 내용으로 분석 요청하기"]
  }
];
