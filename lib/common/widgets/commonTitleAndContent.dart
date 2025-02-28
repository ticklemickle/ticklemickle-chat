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
            style: contentStyle ?? TextStyle(fontSize: 15),
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
    Color normalTextColor = Colors.black, // 기본 텍스트 색상을 지정
  }) {
    if (highlightWords.isEmpty) {
      return [TextSpan(text: text, style: TextStyle(color: normalTextColor))];
    }

    final spans = <TextSpan>[];
    String remainingText = text;

    while (true) {
      int earliestIndex = -1;
      String? earliestWord;

      for (final word in highlightWords) {
        final index = remainingText.indexOf(word);
        if (index != -1 && (earliestIndex == -1 || index < earliestIndex)) {
          earliestIndex = index;
          earliestWord = word;
        }
      }

      if (earliestIndex == -1 || earliestWord == null) {
        spans.add(TextSpan(
            text: remainingText, style: TextStyle(color: normalTextColor)));
        break;
      }

      if (earliestIndex > 0) {
        spans.add(TextSpan(
          text: remainingText.substring(0, earliestIndex),
          style: TextStyle(color: normalTextColor),
        ));
      }

      spans.add(TextSpan(
        text: earliestWord,
        style: TextStyle(color: highlightColor),
      ));

      remainingText =
          remainingText.substring(earliestIndex + earliestWord.length);
    }

    return spans;
  }
}
