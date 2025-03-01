import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/widgets/restartWidget.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_common.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_finance.dart';
import 'package:ticklemickle_m/screens/home/appHome.dart';
import 'package:ticklemickle_m/screens/chatbot/chatBotMain.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_lookalike.dart';
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
        path: '/ChatBotMain/:category',
        builder: (context, state) {
          final String category = state.pathParameters['category'] ?? '';
          return ChatBotScreen(category: category);
        },
      ),
      GoRoute(
        path: '/ChatBotReult_finance',
        builder: (context, state) => const ChatBotResultFinance(),
      ),
      GoRoute(
        path: '/ChatBotResult_common',
        builder: (context, state) {
          final category = state.uri.queryParameters['category'] ?? '';
          if (category.isEmpty || !(state.extra is List<double>)) {
            return const RedirectToAppHome();
          }
          final scoreList = state.extra as List<double>;
          return ChatBotResultCommon(category: category, scoreList: scoreList);
        },
      ),
      GoRoute(
        path: '/ChatBotLookalike',
        builder: (context, state) => const ChatBotLookalikeScreen(),
      ),
      GoRoute(
        path: '/myInfo',
        builder: (context, state) => const MyInfo(useAppHome: false),
      ),
      GoRoute(
        path: '/settingMain',
        builder: (context, state) => const Settingmain(useAppHome: false),
      ),
    ],
    errorBuilder: (context, state) {
      return const RedirectToAppHome();
    },
  );
}
