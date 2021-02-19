import 'package:flutter/material.dart';
import 'package:template_flutter/config/application.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';

import 'common_utils.dart';

class MyDialog {
  static Widget renderWidget;
  static BuildContext _context;
  static String _alertText = '好的';
  static String _cancelText = '取消';
  static int _alertType = 1; // 1 只有一个按钮的 2 两个按钮
  static Function _callBack;
  static Function _cancelCallBack;
  static bool barrierDismissible = true;

  // 初始化dialog
  static void initDialog(Widget widget, BuildContext context, {
    alertText: '好的',
    cancelText: '取消',
    alertType: 1,
    callBack,
    cancelCallBack,
    barrierDismissible: true
  }) {
    renderWidget = widget;
    _context = context;
    _cancelText = cancelText;
    _alertText = alertText;
    _alertType = alertType;
    _callBack = callBack;
    _cancelCallBack = cancelCallBack;
    barrierDismissible = barrierDismissible;
  }

  static void openDialog() {
    if (_context == null) return;
    showDialog(
        context: _context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: Utils.getWidth(5)),
            child: Stack(
              children: <Widget>[
                Container(
                    width: Application.screenWidth - Utils.getWidth(60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Utils.getWidth(12))),
                    child: renderWidget),
                Positioned(
                  top: Utils.getWidth(12),
                  right: Utils.getWidth(15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(_context).pop();
                    },
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
          );
        });
  }

  static void openAlertDialog() {
    if (_context == null) return;
    showDialog(
        context: _context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Utils.getWidth(250),
                  padding: EdgeInsets.only(
                    left: Utils.getWidth(24),
                    right: Utils.getWidth(24),
                    top: Utils.getWidth(25),
                    bottom: Utils.getWidth(5),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Utils.getWidth(5))),
                  child: Column(
                    children: <Widget>[
                      renderWidget,
                      _alertType == 1
                          ? Container(
                              width: double.infinity,
                              height: Utils.getWidth(45),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 0.5,
                                          color: AppColors.borderColor))),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(_context).pop();
                                  if (_callBack != null) {
                                    _callBack();
                                    _callBack = null;
                                  }
                                },
                                child: Text(
                                  _alertText,
                                  style: themeText15,
                                ),
                              ),
                            )
                          : Container(
                              height: Utils.getWidth(45),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 0.5,
                                          color: AppColors.borderColor))),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(_context).pop();
                                      },
                                      child: Text(
                                        '取消',
                                        style: defaultText15,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () {
                                        _callBack();
                                        Navigator.of(_context).pop();
                                      },
                                      child: Text(
                                        _alertText,
                                        style: themeText15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  static void openIosDialog() {
    if (_context == null) return;
    showDialog(
        context: _context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: Utils.getWidth(270),
                  padding: EdgeInsets.only(
                    top: Utils.getWidth(20),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Utils.getWidth(12))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Utils.getWidth(20)),
                        child: Column(
                          children: <Widget>[renderWidget],
                        ),
                      ),
                      Container(
                        width: Utils.getWidth(270),
                        height: Utils.getWidth(44),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 0.7, color: AppColors.borderColor))),
                        child: _alertType == 1
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(_context).pop();
                                  if (_callBack != null) {
                                    _callBack();
                                    _callBack = null;
                                  }
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: Utils.getWidth(270),
                                  height: Utils.getWidth(44),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _alertText,
                                    style: text16WithForget,
                                  ),
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        try {
                                          if (_cancelCallBack != null) {
                                            _cancelCallBack();
                                          }
                                        } catch(err) {}
                                        Navigator.of(_context).pop();
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: 0.7,
                                                    color: AppColors
                                                        .borderColor))),
                                        child: Text(
                                          _cancelText,
                                          style: _cancelText == '好的'
                                              ? text16WithForget
                                              : defaultText16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(_context).pop();
                                        _callBack();
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          _alertText,
                                          style: text16WithForget,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
