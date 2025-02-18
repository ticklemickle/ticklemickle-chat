// toast_helper.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';

bool isToastVisible = false; // ✅ Toast 중복 방지 변수

void showToast(BuildContext context, String message) {
  if (isToastVisible) return; // ✅ 이미 Toast가 표시 중이면 실행하지 않음

  isToastVisible = true; // ✅ Toast 상태 활성화

  if (kIsWeb) {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating, // ✅ 화면 위에 띄우기
      margin: EdgeInsets.only(top: 10, left: 16, right: 16), // ✅ 화면 상단 여백 추가
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((_) {
      isToastVisible = false; // ✅ Toast가 사라지면 다시 활성화 가능하도록 변경
    });
  } else {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP, // ✅ 항상 화면 상단에 표시
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
