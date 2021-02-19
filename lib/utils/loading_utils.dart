import 'package:flutter/material.dart';
import 'package:template_flutter/constants/app_colors.dart';

class LoadingUtils {
  static BuildContext ctx;
  static OverlayEntry _overlayEntry;

  static void showLoading() {
    _cancelLoading();
    try {
      _overlayEntry = new OverlayEntry(builder: (ctx) {
        return LoadingsCircle();
      });
    } catch(err) {

    }
    Overlay.of(ctx).insert(_overlayEntry);
  }

  static _cancelLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void closeLoading() {
    _cancelLoading();
  }
}

class LoadingsCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.center,
//      margin: EdgeInsets.only(top: Utils.getWidth(100)),
      child: CircularProgressIndicator(
        backgroundColor: AppColors.textColorD,
        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColor),
      ),
    );
  }
}

class SmallLoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.topCenter,
      child: CircularProgressIndicator(
        backgroundColor: AppColors.textColorD,
        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColor),
      ),
    );
  }
}
