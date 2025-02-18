import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsCheckbox extends StatefulWidget {
  final ValueChanged<bool>? onChanged; // 상태 변경 콜백 추가

  TermsCheckbox({Key? key, this.onChanged}) : super(key: key);

  @override
  TermsCheckboxState createState() => TermsCheckboxState();
}

class TermsCheckboxState extends State<TermsCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // 내부 위젯이 터치를 막지 않도록 설정
      onTap: () {
        setState(() {
          isChecked = !isChecked; // 상태 변경
          if (widget.onChanged != null) {
            widget.onChanged!(isChecked); // 변경된 값 전달
          }
        });
      },
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.check_circle,
            color: isChecked ? MyColors.mainColor : MyColors.grey,
          ),
          SizedBox(width: 10),
          Text(
            "[필수] 티끌미끌 모임 서비스 이용약관",
            style: TextStyle(
              fontSize: 14,
              color: isChecked ? Colors.black : MyColors.darkGrey,
              fontWeight: isChecked ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),
          GestureDetector(
            behavior: HitTestBehavior.opaque, // 아이콘 주변 영역도 클릭 가능하도록 설정
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://superb-nitrogen-81f.notion.site/18d48074a12d80d8ab2cec2977e2ece7?pvs=4');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                debugPrint("Could not launch $url");
              }
            },
            child: Icon(
              Icons.chevron_right,
              color: MyColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
