import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class CircleTitleItem extends StatelessWidget {
  final String title;
  final String? imagePath;
  final Color defaultColor;
  final String? content;

  const CircleTitleItem({
    Key? key,
    required this.title,
    this.content,
    this.imagePath,
    this.defaultColor = MyColors.mainlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: defaultColor, // 배경색 적용
          backgroundImage:
              hasImage ? AssetImage(imagePath!) as ImageProvider : null,
          child: !hasImage && content != null // 이미지가 없고, content가 있을 때만 표시
              ? Text(
                  content!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
