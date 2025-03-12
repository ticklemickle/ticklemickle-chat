import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/BackButtonHandler.dart';
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
    return BackButtonHandler(
        onBackButtonPressed: () async {
          context.go(RouteConst.appHome);
          return false;
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
                  context.push(RouteConst.settingMain);
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
                      if (appfinanceList[index]["category"] ==
                          CategoryConst.questionsBasicStatus) {
                        context.push(
                            '/ChatBotFinance/${appfinanceList[index]["category"]}');
                      } else {
                        context.push(
                            '/ChatBotMain/${appfinanceList[index]["category"]}');
                      }
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
