import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

/// 공통 Text 위젯 예시
/// - [title] : 제목 (FontWeight.w600 적용)
/// - [content] : 본문
/// - [highlightWords] : 본문 내 강조할 단어(문자열) 목록
/// - [highlightColor] : 강조 색상
/// - [titleStyle], [contentStyle] : 기본 스타일을 오버라이드하고 싶을 때 사용
class CommonTextWidget extends StatelessWidget {
  final String title;
  final String content;
  final List<String> highlightWords;
  final Color highlightColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  const CommonTextWidget({
    Key? key,
    required this.title,
    required this.content,
    this.highlightWords = const [],
    this.highlightColor = MyColors.mainDarkColor,
    this.titleStyle,
    this.contentStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        /// 1) 제목
        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 8),

        /// 2) 본문 (RichText를 사용해 특정 단어만 색상 강조)
        RichText(
          text: TextSpan(
            style: contentStyle ?? DefaultTextStyle.of(context).style,
            children: _buildHighlightedText(
              text: content,
              highlightWords: highlightWords,
              highlightColor: highlightColor,
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  /// 본문 내에서 [highlightWords] 목록에 있는 단어를 찾아 색상을 입히는 메서드
  List<TextSpan> _buildHighlightedText({
    required String text,
    required List<String> highlightWords,
    required Color highlightColor,
  }) {
    // 강조할 단어 목록이 비어있다면, 통째로 반환
    if (highlightWords.isEmpty) {
      return [TextSpan(text: text)];
    }

    final spans = <TextSpan>[];
    String remainingText = text;

    while (true) {
      // 가장 먼저 발견되는 강조 단어를 찾음
      int earliestIndex = -1;
      String? earliestWord;

      for (final word in highlightWords) {
        final index = remainingText.indexOf(word);
        // 발견된 단어 중 가장 앞에 있는 단어를 찾음
        if (index != -1 && (earliestIndex == -1 || index < earliestIndex)) {
          earliestIndex = index;
          earliestWord = word;
        }
      }

      // 더 이상 강조 단어가 없다면, 남은 텍스트를 그대로 추가하고 종료
      if (earliestIndex == -1 || earliestWord == null) {
        spans.add(TextSpan(text: remainingText));
        break;
      }

      // 강조 단어 전까지의 텍스트 추가
      if (earliestIndex > 0) {
        spans.add(TextSpan(text: remainingText.substring(0, earliestIndex)));
      }

      // 강조 단어 추가 (색상 및 굵기 적용 등)
      spans.add(
        TextSpan(
          text: earliestWord,
          style: TextStyle(
            color: highlightColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
      );

      // 처리한 부분 이후의 텍스트로 갱신
      remainingText =
          remainingText.substring(earliestIndex + earliestWord.length);
    }

    return spans;
  }
}
