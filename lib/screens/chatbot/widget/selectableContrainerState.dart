import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonDialog.dart';
import 'package:ticklemickle_m/screens/setting/myInfo.dart';

class SelectableContainer extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableContainer({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  _SelectableContainerState createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  @override
  Widget build(BuildContext context) {
    // print(widget.label);
    return GestureDetector(
      onTap: () {
        if (widget.label == "변경하기") {
          CommonDialog.show(
            context: context,
            title: '정보 수정 화면으로 이동하시겠습니까?',
            leftButtonText: '아니오',
            leftButtonAction: () => Navigator.pop(context),
            rightButtonText: '예',
            rightButtonAction: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyInfo(useAppHome: true)),
              );
            },
          );
        } else {
          widget.onTap();
        }
      },
      child: Container(
        width: 80,
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: widget.isSelected ? MyColors.mainDarkColor : Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).toInt()),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: (widget.label == "o" || widget.label == "x")
            ? Image.asset(
                'assets/chatbot/question/${widget.label}.png',
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              )
            : Text(
                widget.label, maxLines: 2, // 최대 두 줄로 표시
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      widget.isSelected ? MyColors.mainDarkColor : Colors.black,
                ),
              ),
      ),
    );
  }
}
