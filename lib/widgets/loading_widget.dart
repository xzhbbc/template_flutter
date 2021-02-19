import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/utils/common_utils.dart';

/// 白色底的loading
class LoadingWhite extends StatefulWidget {
  @override
  _LoadingWhiteState createState() => _LoadingWhiteState();
}

class _LoadingWhiteState extends State<LoadingWhite>
    with TickerProviderStateMixin {
  AnimationController controller1Round;
  AnimationController controller2Round;
  AnimationController controller3Round;
  Animation<double> animation;

  CurvedAnimation offsetCurvedAnimation1Round;
  CurvedAnimation offsetCurvedAnimation2Round;
  CurvedAnimation offsetCurvedAnimation3Round;
  bool _isControllerDisposed = false;

  @override
  void initState() {
    super.initState();
    controller1Round = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    offsetCurvedAnimation1Round = new CurvedAnimation(
        parent: controller1Round, curve: Cubic(.35, 0, .35, 1));

    controller2Round = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    offsetCurvedAnimation2Round = new CurvedAnimation(
        parent: controller2Round, curve: Cubic(.35, 0, .65, 1));

    controller3Round = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    offsetCurvedAnimation3Round = new CurvedAnimation(
        parent: controller3Round, curve: Cubic(.3, 0, .7, 1));

    // 设置第一圈选择位置
    animation =
        Tween(begin: 0.0, end: 1.1).animate(offsetCurvedAnimation1Round);

    //第三圈
    controller3Round.addStatusListener(control3RoundStatus);
    // 第二圈
    controller2Round.addStatusListener(smallStatus);
    // 第一圈
    controller1Round.addStatusListener(controlStatus);
    if (_isControllerDisposed) return;
    if (mounted) {
      controller1Round.forward();
    }
  }

  void smallStatus(status) async {
    if (_isControllerDisposed) return;
    if (status == AnimationStatus.completed) {
      controller2Round.reset();
      setState(() {
        // 开始第三圈
        animation =  Tween(begin: 0.97, end: 1.0).animate(offsetCurvedAnimation3Round);
      });
//      await Future.delayed(new Duration(milliseconds: 400));
     if (mounted) {
       controller3Round.forward();
     }
//      setState(() {
//        animation = Tween(begin: 0.0, end: 1.2).animate(controller1Round);
//      });
//      await Future.delayed(new Duration(milliseconds: 400));
//      controller1Round.forward();
    }
  }

  void control3RoundStatus(status) async{
    if (_isControllerDisposed) return;
    if (status == AnimationStatus.completed) {
      controller3Round.reset();
      setState(() {
        // 从新开始
        animation = Tween(begin: 0.0, end: 1.1).animate(controller1Round);
      });
      await Future.delayed(new Duration(milliseconds: 200));
      if (mounted) {
        controller1Round.forward();
      }
    }
  }

  void controlStatus(status) {
    if (_isControllerDisposed) return;

    if (status == AnimationStatus.completed) {
      controller1Round.reset();
      setState(() {
        // 设置第二圈旋转位置
        animation =
            Tween(begin: 1.1, end: 0.97).animate(offsetCurvedAnimation2Round);
      });
     if (mounted) {
       controller2Round.forward();
     }
    }
  }

  @override
  void dispose() {
    _isControllerDisposed = true;
    controller1Round?.dispose();
    controller2Round?.dispose();
    controller3Round?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotationTransition(
        alignment: Alignment.center,
        turns: animation,
        child: Center(
          child: Image.asset(
            Utils.wrapAssets('loading_A.png'),
            width: ScreenUtil().setWidth(25),
            height: ScreenUtil().setWidth(25),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// 彩色loading
class LoadingColor extends StatefulWidget {
  @override
  _LoadingColorState createState() => _LoadingColorState();
}

class _LoadingColorState extends State<LoadingColor>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controllerSmall;
  Animation<double> animation;
  CurvedAnimation offsetCurvedAnimation;
  bool _isControllerDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    controllerSmall = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animation = Tween(begin: 0.0, end: 1.2).animate(controller);
    offsetCurvedAnimation =
        new CurvedAnimation(parent: controllerSmall, curve: Curves.easeIn);
    controllerSmall.addStatusListener(smallStatus);
    controller.addStatusListener(controlStatus);
    if (_isControllerDisposed) return;
    if (mounted) {
      controller.forward();
    }
  }

  void smallStatus(status) async {
    if (_isControllerDisposed) return;
    if (status == AnimationStatus.completed) {
      controllerSmall.reset();
      setState(() {
        animation = Tween(begin: 0.0, end: 1.2).animate(controller);
      });
      await Future.delayed(new Duration(milliseconds: 400));
      if (mounted) {
        controller.forward();
      }
    }
  }

  void controlStatus(status) {
    if (_isControllerDisposed) return;
    if (status == AnimationStatus.completed) {
      controller.reset();
      setState(() {
        animation = Tween(begin: 1.2, end: 1.0).animate(offsetCurvedAnimation);
      });
      if (mounted) {
        controllerSmall.forward();
      }
    }
  }

  @override
  void dispose() {
    _isControllerDisposed = true;
    controller?.dispose();
    controllerSmall?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotationTransition(
        alignment: Alignment.center,
        turns: animation,
        child: Image.asset(
          Utils.wrapAssets('loading_B.png'),
          width: ScreenUtil().setWidth(25),
          height: ScreenUtil().setWidth(25),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
