import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/config/application.dart';
import 'package:template_flutter/utils/loading_utils.dart';
import 'package:template_flutter/utils/navigator_util.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      goPage();
    }
  }

  void goPage() async{
    bool checkLogin = true;
    // 模拟延迟
    await Future.delayed(Duration(milliseconds: 2000));
    if (checkLogin) {
      NavigatorUtil.goHomePage(context);
    } else {
      // 跳转登陆页面
    }
  }

  @override
  Widget build(BuildContext context) {
    // 设置设计稿尺寸
    ScreenUtil.instance = ScreenUtil(width: 375, height: 667)..init(context);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
    LoadingUtils.ctx = context; // 全局Loading注入context
    Application.ctx = context;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: Application.screenWidth,
          height: Application.screenHeight,
          alignment: Alignment.center,
//          child: Image.asset(
//            Utils.wrapAssets('start_page.png'),
//            fit: BoxFit.cover,
//          ),
        ),
      ),
    );
  }
}
