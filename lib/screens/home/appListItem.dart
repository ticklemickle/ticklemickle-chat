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
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColors.lightestGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.contain),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  if (subtitle.isNotEmpty)
                    Text(subtitle,
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: MyColors.mainDarkColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$participants명 참여",
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
