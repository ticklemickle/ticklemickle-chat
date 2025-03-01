import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticklemickle_m/screens/home/appHome.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;

  const ErrorBoundary({Key? key, required this.child}) : super(key: key);

  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      setState(() {
        hasError = true;
      });
      _navigateToHome(); // 에러 발생 시 이동
    };
  }

  void _navigateToHome() {
    Future.microtask(() {
      final router = GoRouter.of(context);
      router.go('/AppHome'); // 에러 발생 시 '/AppHome'으로 이동
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const AppHome(); // 에러 발생 시 AppHome 직접 표시
    }
    return widget.child;
  }
}
