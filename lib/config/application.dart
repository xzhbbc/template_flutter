import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './config.dart';

enum ENV {
  PRODUCTION,
  DEV,
  PRE,
  TEST,
  OWNER,
}

class Application {
  static ENV env = ENV.TEST;
  static SharedPreferences sp;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static FluroRouter router;
  static Directory temporaryDirectory;
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static BuildContext ctx;

  static Future initSpTemp() async {
    temporaryDirectory = await getTemporaryDirectory();
    sp = await SharedPreferences.getInstance();
  }

  /// 所有获取配置的唯一入口
  static Config get config {
    if (Application.env == ENV.PRODUCTION) {
      return configPro;
    }
    if (Application.env == ENV.DEV) {
      return configDev;
    }
    if (Application.env == ENV.PRE) {
      return configPre;
    }
    if (Application.env == ENV.TEST) {
      return configTest;
    }
    if (Application.env == ENV.OWNER) {
      return myTest;
    }
    return Config();
  }
}