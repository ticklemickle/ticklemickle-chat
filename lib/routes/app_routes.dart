import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/common/widgets/restartWidget.dart';
import 'package:ticklemickle_m/screens/chatbot/chatBotBasic.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_common.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_basic.dart';
import 'package:ticklemickle_m/screens/home/appHome.dart';
import 'package:ticklemickle_m/screens/chatbot/chatBotMain.dart';
import 'package:ticklemickle_m/screens/chatbot/results/chatBotResult_lookalike.dart';
import 'package:ticklemickle_m/screens/setting/myInfo.dart';
import 'package:ticklemickle_m/screens/setting/settingMain.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RouteConst.appHome,
    routes: [
      GoRoute(
        path: RouteConst.appHome,
        builder: (context, state) => const AppHome(),
      ),
      GoRoute(
        path: '${RouteConst.chatBotMain}/:category',
        builder: (context, state) {
          final String category = state.pathParameters['category'] ?? '';
          return ChatBotMain(category: category);
        },
      ),
      GoRoute(
        path: '${RouteConst.chatBotBasic}/:category',
        builder: (context, state) {
          final String category = state.pathParameters['category'] ?? '';
          return ChatBotBasic(category: category);
        },
      ),
      GoRoute(
        path: RouteConst.chatBotResultBasic,
        builder: (context, state) => const ChatBotResultBasic(),
      ),
      GoRoute(
        path: RouteConst.chatBotResultCommon,
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
        path: RouteConst.chatBotResultLookalike,
        builder: (context, state) => const ChatBotLookalikeScreen(),
      ),
      GoRoute(
        path: RouteConst.myInfo,
        builder: (context, state) => const MyInfo(useAppHome: false),
      ),
      GoRoute(
        path: RouteConst.settingMain,
        builder: (context, state) => const Settingmain(useAppHome: false),
      ),
    ],
    errorBuilder: (context, state) {
      return const RedirectToAppHome();
    },
  );
}
