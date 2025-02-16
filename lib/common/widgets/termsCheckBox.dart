import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';

class TermsCheckbox extends StatefulWidget {
  @override
  TermsCheckboxState createState() => TermsCheckboxState();
}

class TermsCheckboxState extends State<TermsCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked; // 상태 변경
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 10),
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
