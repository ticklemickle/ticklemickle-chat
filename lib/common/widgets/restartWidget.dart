import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/common/utils/const.dart';

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

// 새 리다이렉트 위젯
class RedirectToAppHome extends StatelessWidget {
  const RedirectToAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 프레임이 완료된 후 '/AppHome'으로 이동
    Future.microtask(() {
      context.go(RouteConst.appHome);
    });
    // 리다이렉트 전까지 표시할 임시 UI (로딩 인디케이터 등)
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
