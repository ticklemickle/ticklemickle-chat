import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BackButtonHandler extends StatefulWidget {
  final Widget child;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Future<bool> Function()? onBackButtonPressed;
  final double toastBottomOffset;

  const BackButtonHandler({
    super.key,
    required this.child,
    this.scaffoldKey,
    this.onBackButtonPressed,
    this.toastBottomOffset = 0,
  });

  @override
  State<BackButtonHandler> createState() => _BackButtonHandlerState();
}

class _BackButtonHandlerState extends State<BackButtonHandler> {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() async {
    if (widget.onBackButtonPressed != null) {
      return widget.onBackButtonPressed!();
    }

    if (widget.scaffoldKey?.currentState != null &&
        widget.scaffoldKey!.currentState!.isDrawerOpen) {
      widget.scaffoldKey!.currentState!.closeDrawer();
      return false;
    }

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      FToast fToast = FToast();
      fToast.init(context);
      fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          margin: EdgeInsets.only(bottom: widget.toastBottomOffset),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black54,
          ),
          child: const Text(
            "'뒤로' 버튼을 한 번 더 누르면 종료됩니다.",
            style: TextStyle(color: Colors.white),
          ),
        ),
        gravity: ToastGravity.BOTTOM,
      );

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            currentBackPressTime = null;
          });
        }
      });

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: widget.child,
    );
  }
}
