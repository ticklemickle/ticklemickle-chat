import 'package:flutter/material.dart';
import 'package:ticklemickle_m/common/themes/colors.dart';
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
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: '티끌미끌',
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.mainBackgroundColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.mainColor,
          selectionColor: MyColors.mainlightestColor,
          selectionHandleColor: MyColors.mainDarkColor,
        ),
      ),
      // ErrorBoundary를 builder로 래핑하여 GoRouter context를 포함하게 함
      builder: (context, child) {
        return ErrorBoundary(child: child!);
      },
    );
  }
}
