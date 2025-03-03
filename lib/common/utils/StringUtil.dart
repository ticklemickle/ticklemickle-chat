import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

String processText(String text) {
  final RegExp emoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
  String fullText = '';
  List<String> words = text.split(' ');
  for (var i = 0; i < words.length; i++) {
    fullText += emoji.hasMatch(words[i])
        ? words[i]
        : words[i]
            .replaceAllMapped(RegExp(r'(\S)(?=\S)'), (m) => '${m[1]}\u200D');
    if (i < words.length - 1) fullText += ' ';
  }
  return fullText;
}

/* 한국어 띄어쓰기 기준으로 개행 기능 */
String wrapTextBySpaces(String text, double maxWidth, TextStyle style) {
  final words = text.split(" ");
  String currentLine = "";
  List<String> lines = [];

  for (final word in words) {
    // 현재 줄에 단어를 추가한 경우의 텍스트
    final testLine = currentLine.isEmpty ? word : "$currentLine $word";

    // TextPainter로 testLine의 너비 측정
    final textPainter = TextPainter(
      text: TextSpan(text: testLine, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // testLine의 너비가 maxWidth를 초과하면 현재 줄을 완성
    if (textPainter.width > maxWidth) {
      if (currentLine.isEmpty) {
        // 단어 하나가 maxWidth보다 클 경우 그냥 추가
        lines.add(testLine);
        currentLine = "";
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    } else {
      currentLine = testLine;
    }
  }
  // 남은 텍스트가 있다면 마지막 줄에 추가
  if (currentLine.isNotEmpty) {
    lines.add(currentLine);
  }

  return lines.join("\n");
}

class ChatbotSelectableText extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ChatbotSelectableText({
    Key? key,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: isSelected ? MyColors.mainDarkColor : Colors.black,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        // LayoutBuilder의 constraints.maxWidth 를 기준으로 텍스트 개행 처리
        final wrappedLabel =
            wrapTextBySpaces(label, constraints.maxWidth, textStyle);

        return Text(
          textAlign: TextAlign.center,
          wrappedLabel,
          maxLines: 2, // 최대 두 줄로 표시
          softWrap: true, // 자동 개행 허용
          style: textStyle,
        );
      },
    );
  }
}

// 입력된 숫자를 만원 단위로 포맷팅
String formatAmount(String value) {
  if (value.isEmpty) return "";
  final int amount = int.tryParse(value) ?? 0;
  if (amount == 0) {
    return "$amount 원";
  } else if (amount < 10000) {
    return "$amount 만원";
  } else {
    final int oku = amount ~/ 10000;
    final int remain = amount % 10000;
    if (remain == 0) {
      return "${oku}억";
    }
    return "${oku}억 ${remain}만원";
  }
}

class AmountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // 첫 번째 숫자가 '0'이면 유지
    if (digits.length > 1 && digits.startsWith('0')) {
      digits = digits.substring(0, 1);
    }

    // 포맷 적용
    String formatted = formatAmount(digits);

    // 커서 위치 유지
    int baseOffset = newValue.selection.baseOffset;
    int newOffset = baseOffset - (newValue.text.length - digits.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: newOffset.clamp(0, formatted.length),
      ),
    );
  }
}
