import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/screens/home/appHome.dart';
import 'package:ticklemickle_m/screens/chatbot/chatBotMain.dart';
import 'package:ticklemickle_m/screens/chatbot/chatBotResult.dart';
import 'package:ticklemickle_m/screens/setting/myInfo.dart';
import 'package:ticklemickle_m/screens/setting/settingMain.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/AppHome',
    routes: [
      GoRoute(
        path: '/AppHome',
        builder: (context, state) => const AppHome(),
      ),
      GoRoute(
        path: '/ChatBotMain',
        builder: (context, state) => const ChatBotScreen(),
      ),
      GoRoute(
        path: '/ChatBotResult',
        builder: (context, state) => const ChatBotResultScreen(),
      ),
      GoRoute(
        path: '/myInfo',
        builder: (context, state) => const MyInfo(),
      ),
      GoRoute(
        path: '/settingMain',
        builder: (context, state) => const Settingmain(),
      ),
    ],
  );
}
