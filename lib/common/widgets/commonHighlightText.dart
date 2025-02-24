import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class CommonHighlightText extends StatelessWidget {
  final String leadingText;
  final String highlightedText;
  final String trailingText;

  final double defaultFontSize;
  final Color defaultColor;
  final FontWeight defaultFontWeight;

  final double highlightedFontSize;
  final Color highlightedColor;
  final FontWeight highlightedFontWeight;

  const CommonHighlightText({
    Key? key,
    required this.leadingText,
    required this.highlightedText,
    required this.trailingText,
    this.defaultFontSize = 18.0,
    this.defaultColor = Colors.black,
    this.defaultFontWeight = FontWeight.w600,
    this.highlightedFontSize = 19.0,
    this.highlightedColor = MyColors.mainDarkColor,
    this.highlightedFontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: TextStyle(
          fontSize: defaultFontSize,
          fontWeight: defaultFontWeight,
          color: defaultColor,
        ),
        children: [
          TextSpan(text: leadingText),
          TextSpan(
            text: highlightedText,
            style: TextStyle(
              fontSize: highlightedFontSize,
              color: highlightedColor,
              fontWeight: highlightedFontWeight,
            ),
          ),
          TextSpan(text: trailingText),
        ],
      ),
    );
  }
}
