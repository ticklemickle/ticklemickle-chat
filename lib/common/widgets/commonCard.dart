import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class CommonCard extends StatelessWidget {
  final String? imagePath; // 이미지 경로 (nullable)
  final IconData defaultIcon; // 기본 아이콘
  final Color? backgroundColor; // 배경 색상
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CommonCard({
    super.key,
    this.imagePath, // 이미지가 없을 수도 있음
    this.defaultIcon = Icons.group, // 기본 아이콘 설정
    this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? MyColors.lightestGrey,
      elevation: 0, // ✅ 그림자 제거
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: MyColors.lightestGrey),
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min, // 🔹 Row가 최소 크기로 유지되도록 설정
          children: [
            _buildImageOrIcon(),
            const SizedBox(width: 12), // 🔹 아이콘과 타이틀 사이 간격 추가
          ],
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

  /// ✅ 이미지가 존재하면 `Image.asset`, 없으면 기본 아이콘 표시
  Widget _buildImageOrIcon() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Image.asset(
        imagePath!,
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) {
          // ✅ 이미지 로드 실패 시 기본 아이콘 반환
          return Icon(defaultIcon, size: 40, color: Colors.white);
        },
      );
    } else {
      // ✅ 이미지 경로가 없으면 기본 아이콘 반환
      return Icon(defaultIcon, size: 40, color: Colors.white);
    }
  }
}
