import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/config/application.dart';
import 'package:template_flutter/routes/routes.dart';

class NavigatorUtil {
  static Future _navigateTo(BuildContext context, String path,
      {bool replace = false,
        bool clearStack = false,
        Duration transitionDuration = const Duration(milliseconds: 250),
        RouteTransitionsBuilder transitionBuilder}) {
    return Application.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      transition: TransitionType.material,
    );
  }

  // 返回
  static void goBack(BuildContext context) {
    Application.router.pop(context);
  }

  // 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  // 首页
  static void goHomePage(BuildContext context) {
    _navigateTo(context, Routes.home, clearStack: true);
  }
}