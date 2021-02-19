import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/application.dart';
import 'pages/splash_page.dart';
import 'routes/routes.dart';
import 'provider/provider_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // 固定竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Application.initSpTemp();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final router = new FluroRouter();
    Routes.configureRoutes(router);
    // 这里设置项目环境
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        hideFooterWhenNotFull: true, // 列表数据不满一页，不触发加载更多
        child: MultiProvider(
          providers: providers,
          child: MaterialApp(
            navigatorKey: Application.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: '这是个模板应用',
            theme: ThemeData(
              primaryColor: Colors.white,
              platform: TargetPlatform.iOS,
//            fontFamily: 'PingFang'
            ),
            localizationsDelegates: const [
              RefreshLocalizations.delegate, //下拉刷新
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
//            const Locale('en', 'US'),
              const Locale("zh", "CH"),
              const Locale('zh', ''), // China
//            const Locale("en", "US")
            ],
            home: SplashPage(),
            onGenerateRoute: Application.router.generator,
          ),
        )
    );
  }
}

