// toast_helper.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';

bool isToastVisible = false; // ✅ Toast 중복 방지 변수

void showToast(BuildContext context, String message) {
  if (isToastVisible) return; // ✅ 이미 Toast가 표시 중이면 실행하지 않음

  isToastVisible = true;

  if (kIsWeb) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      isToastVisible = false;
    });
  } else {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    ).then((_) {
      Future.delayed(Duration(seconds: 2), () {
        isToastVisible = false; // ✅ Toast 지속시간 이후 상태 초기화
      });
    });
  }
}
