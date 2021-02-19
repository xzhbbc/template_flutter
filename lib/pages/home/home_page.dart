import 'package:flutter/material.dart';
import 'package:template_flutter/widgets/global_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: '首页',
      ),
      body: Container(
        child: Text('我是首页'),
      ),
    );
  }
}
