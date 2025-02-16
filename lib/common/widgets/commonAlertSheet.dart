import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/termsCheckBox.dart';

void showCommonAlertSheet({
  required BuildContext context,
  required String title,
  required String subTitle,
  required String content,
  required String confirmText,
  required VoidCallback onConfirm,
  String cancelText = "닫기",
  VoidCallback? onCancel,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 14, color: MyColors.darkGrey),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 40),
                  TermsCheckbox(),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 400,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                onPressed: onConfirm,
                child: Text(confirmText,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              ),
            ),
            SizedBox(
              width: 80,
              height: 55,
              child: TextButton(
                onPressed: onCancel ?? () => Navigator.pop(context),
                child: Text(cancelText,
                    style: TextStyle(fontSize: 14, color: MyColors.darkGrey)),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}
