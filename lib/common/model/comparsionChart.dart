class ComparisonData {
  final String title; // 예: '소득', '자산' 등
  final double averageValue; // 평균값
  final double myValue; // 내 값
  final String averageLabel; // 평균값 라벨
  final String myLabel; // 내 값 라벨

  const ComparisonData({
    required this.title,
    required this.averageValue,
    required this.myValue,
    required this.averageLabel,
    required this.myLabel,
  });
}
