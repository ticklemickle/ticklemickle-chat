const List<Map<String, dynamic>> financeBasicTest = [
  {"type": "text", "message": "안녕하세요. 금융 지식 테스트를 시작하겠습니다!"},
  {
    "type": "choice",
    "message": "먼저 저희쪽에 등록한 정보가 맞는지 확인해주세요. \n아래 정보가 맞나요?\n\n1990년생 남성",
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
