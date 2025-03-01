import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonToast.dart';
import 'package:ticklemickle_m/screens/home/appList/appfinanceList.dart';
import 'appListItem.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    DateTime? backPressedTime;

    return PopScope(
        // 사용자가 현재 화면을 pop할 수 없도록 false로 설정
        canPop: false,
        onPopInvoked: (bool didPop) {
          // 만약 이미 pop 처리가 된 경우에는 추가 동작 없이 반환
          if (didPop) {
            return;
          }

          DateTime nowTime = DateTime.now();
          // 마지막 뒤로가기 시간과 현재 시간의 차이가 2초보다 크면 스낵바로 안내 메시지 출력
          if (backPressedTime == null ||
              nowTime.difference(backPressedTime!) >
                  const Duration(seconds: 2)) {
            backPressedTime = nowTime;
            showToast(context, "결제창 연결에 실패했습니다.");
          } else {
            // 2초 이내에 두 번째 누름 -> 앱 종료
            SystemNavigator.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: const Text(
              "경제 근육 키우기",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.menu, size: 28),
                onPressed: () {
                  Navigator.pushNamed(context, '/settingMain');
                },
              ),
            ],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            itemCount: appfinanceList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(
                          '/ChatBotMain/${appfinanceList[index]["category"]}');
                      // if (index % 4 == 0) {
                      // } else if (index % 4 == 1) {
                      //   context.go('/ChatBotReult_finance');
                      // } else if (index % 4 == 2) {
                      //   context.go('/ChatBotResult_common?type=stock');
                      // } else {
                      //   context.go('/ChatBotResult_common?type=housing');
                      // }
                    },
                    child: AppListItem(
                      title: appfinanceList[index]["title"],
                      subtitle: getSubTitleText(index),
                      imagePath:
                          "assets/icon3D/${appfinanceList[index]["image"]}",
                      participants: appfinanceList[index]["participants"],
                    ),
                  ),
                  if (index < appfinanceList.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(color: MyColors.lightGrey, thickness: 1),
                    ),
                ],
              );
            },
          ),
        ));
  }
}

String getSubTitleText(int index) {
  if (appfinanceList[index]["group"] == "propensity") {
    return "성향 분석";
  } else if (appfinanceList[index]["group"] == "knowledge") {
    return "지식 테스트";
  } else {
    return appfinanceList[index]["subtitle"];
  }
}
