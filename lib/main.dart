import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
import 'package:ticklemickle_m/common/widgets/commonToast.dart';
import 'package:ticklemickle_m/common/widgets/restartWidget.dart';
import 'package:url_strategy/url_strategy.dart';
import 'routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:ticklemickle_m/common/widgets/errorBoundary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy(); //Url 에서 #을 제거
  runApp(const RestartWidget(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: MaterialApp.router(
        routerConfig: AppRoutes.router,
        title: '티끌미끌',
        // 모든 화면에 글로벌 뒤로가기 기능 적용
        builder: (context, child) => BackButtonExitWrapper(child: child!),
        theme: ThemeData(
          scaffoldBackgroundColor: MyColors.mainBackgroundColor,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: MyColors.mainColor,
            selectionColor: MyColors.mainlightestColor,
            selectionHandleColor: MyColors.mainDarkColor,
          ),
        ),
      ),
    );
  }
}

// 글로벌 뒤로가기 종료 기능을 위한 위젯 (StatefulWidget 필요)
class BackButtonExitWrapper extends StatefulWidget {
  final Widget child;
  const BackButtonExitWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  _BackButtonExitWrapperState createState() => _BackButtonExitWrapperState();
}

class _BackButtonExitWrapperState extends State<BackButtonExitWrapper> {
  DateTime? _lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > Duration(seconds: 2)) {
          _lastBackPressTime = now;
          showToast(context, "뒤로 버튼을 한번 더 누르시면 종료됩니다 ");
          return false;
        }
        return true;
      },
      child: widget.child,
    );
  }
}
