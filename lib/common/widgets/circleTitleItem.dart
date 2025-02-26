import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class CircleTitleItem extends StatelessWidget {
  final String title;

  /// 이미지 경로 (null 또는 빈 문자열이면 이미지 없이 배경색 표시)
  final String? imagePath;

  /// 이미지가 없을 경우 원형 배경에 사용할 색상
  final Color defaultColor;

  const CircleTitleItem({
    Key? key,
    required this.title,
    this.imagePath,
    this.defaultColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: MyColors.grey,
          backgroundImage: AssetImage(imagePath!),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
