import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class AppListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final int participants;

  const AppListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60, // 원형 컨테이너 크기
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.darkWhite,
              ),
              child: Center(
                child: Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain, // 이미지가 원 안에 자연스럽게 위치하도록 설정
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle,
                        style:
                            TextStyle(fontSize: 13, color: MyColors.darkGrey)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: participants >= 100 ? MyColors.mainColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$participants명 참여",
                style: TextStyle(
                  fontSize: 12,
                  color: participants >= 100 ? Colors.black : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
