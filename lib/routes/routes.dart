import 'package:fluro/fluro.dart';
import 'route_handles.dart';

class Routes {
  static String home = "/home";

  static void configureRoutes(FluroRouter router) {
    router.define(home, handler: homeHandler);
  }
}