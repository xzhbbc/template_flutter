
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/pages/home/home_page.dart';

var homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
  return HomePage();
});