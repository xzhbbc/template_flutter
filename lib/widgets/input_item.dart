import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';
import 'package:template_flutter/utils/common_utils.dart';
import 'package:template_flutter/widgets/button_radius.dart';

/// hindText 输入框提示文字
/// onChange 输入框值改变
/// isPawssWord 是否是密码
/// showVerify 是否需要验证码
/// verifyHeight 验证码高度
/// verifyWidth 验证码宽度
/// paddingHorizontal
/// hindStyle 输入框文字样式
/// sendCode 验证码回调
/// labelText
/// labelStyle
/// clear 清空回调
/// type 输入类型
/// disabled 可否输入
/// disableCallBack 不可输入回调
/// background 背景颜色
/// borderRadius
/// decoration 重新定义外容器的decoration
/// lastIcon 给最后添加一个图标
/// lastIconClick lastIcon点击回调
/// isBorderBottom 是否有分割线 默认true
/// labelMargin 标题与输入框边距 默认38
/// suffix 后置布局
/// prefixIcon 前置icon
/// tel 需要发送验证码的手机号
/// style 输入文本样式
/// value 外部更改输入框的值
/// textAlign 输入框的样式设置
/// autofocus 聚焦
/// hasSendCode 是否可使用验证码
class InputItem extends StatefulWidget {
  final hindText;
  final onChange;
  final bool isPawssWord;
  final bool showClear;
  final Function clear;
  final bool showVerify;
  final Function sendCode;
  final hindStyle;
  final paddingHorizontal;
  final labelText;
  final TextStyle labelStyle;
  final double labelWidth;
  final TextInputType type;
  final bool disabled;
  final Function disableCallBack;
  final background;
  final decoration;
  final lastIcon;
  final Function lastIconClick;
  final bool isBorderBottom;
  final double labelMargin;
  final Widget suffix;
  final Widget prefixIcon;
  final double verifyHeight;
  final double verifyWidth;
  final String tel;
  final style;
  final String value;
  final disabledPadding;
  final TextAlign textAlign;
  final double height;
  final int maxLines;
  final bool autofocus;
  final Color fillColor;
  final TextInputAction textInputAction;
  final Function onSubmitted;
  final int maxLength;
  final bool showImportant;
  final Function focusCallBack;
  final bool hasSendCode;
  final Function getMaxInput;
  final bool canUseEn;
  final bool resetCode;

  const InputItem(
      {Key key,
      this.hindText,
      @required this.onChange,
      this.isPawssWord,
      this.showClear = true,
      this.clear,
      this.showVerify,
      this.sendCode,
      this.paddingHorizontal = 0,
      this.labelText,
      this.labelStyle,
      this.labelWidth,
      this.type,
      this.disabled = false,
      this.disableCallBack,
      this.background,
      this.decoration,
      this.lastIcon,
      this.lastIconClick,
      this.hindStyle,
      this.isBorderBottom = true,
      this.labelMargin = 38,
      this.suffix,
      this.prefixIcon,
      this.tel,
      this.style,
      this.value,
      this.disabledPadding,
      this.verifyHeight,
      this.textAlign,
      this.verifyWidth,
      this.height,
      this.maxLines = 1,
      this.autofocus = false,
      this.fillColor,
      this.textInputAction = TextInputAction.send,
      this.onSubmitted,
      this.maxLength = 1000,
      this.showImportant = false,
      this.focusCallBack,
      this.hasSendCode = true,
      this.getMaxInput,
      this.canUseEn = false,
      this.resetCode = false})
      : super(key: key);

  _InputItemState createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  String _inputText = "";
  bool _hasdeleteIcon = false;
  bool sendingCode = false;
  bool _showPass = true;
  String sendingText = '重新发送(60)';
  bool _autoFocus = false;
  var times;
  FocusNode _myFocus = FocusNode();
  bool resetCode = false;

  TextEditingController _controller;

  clockTime() {
    int nowClock = 60;
    if (times != null) {
      times.cancel();
      times = null;
    }
    times = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      nowClock--;
      setState(() {
        sendingText = '重新发送($nowClock)';
      });
      if (nowClock == 0) {
        setState(() {
          sendingCode = false;
        });
        timer.cancel();
      }
    });
  }

  void cancelTime() {
    times?.cancel();
    times = null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.autofocus != null) {
      _autoFocus = widget.autofocus;
//      if (widget.autofocus) {
////        FocusScope.of(context).requestFocus(_myFocus);
//      }
    }
    resetCode = widget.resetCode;
    if (widget.value != null && widget.value != "") {
      _inputText = widget.value;
    }
    _controller = new TextEditingController.fromValue(
      TextEditingValue(
        text: _inputText,
        selection: new TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: _inputText.length,
          ),
        ),
      ),
    );
    _myFocus.addListener(focusHandler);
//    _controller.addListener(() {
//      if (mounted) {
//
//      }
//    });
  }

  void focusHandler() {
    bool hasFocus = _myFocus.hasFocus;
    setState(() {
      if (!hasFocus) {
        _hasdeleteIcon = false;
      }
    });
    if (widget.focusCallBack != null) {
      widget.focusCallBack(hasFocus);
    }
  }

  @override
  void didUpdateWidget(InputItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && _controller.text != widget.value) {
      _inputText = widget.value;
      setState(() {
        _controller.text = widget.value;
        _hasdeleteIcon = (_controller.text.isNotEmpty);
      });
    }
    if (widget.resetCode != resetCode) {
      resetCode = widget.resetCode;
      setState(() {
        sendingCode = false;
      });
      times.cancel();
    }
    if (widget.autofocus != null && _autoFocus != widget.autofocus) {
      if (widget.autofocus) {
        FocusScope.of(context).requestFocus(_myFocus);
      }
      _autoFocus = widget.autofocus;
    }
  }

  @override
  void dispose() {
    cancelTime();
    _myFocus.removeListener(focusHandler);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    _controller = new TextEditingController.fromValue(
//      TextEditingValue(
//        text: _inputText,
//        selection: new TextSelection.fromPosition(
//          TextPosition(
//            affinity: TextAffinity.downstream,
//            offset: _inputText.length,
//          ),
//        ),
//      ),
//    );
    return Container(
      height:
          widget.height != null ? ScreenUtil().setWidth(widget.height) : null,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(widget.paddingHorizontal),
      ),
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.background != null ? widget.background : Colors.white,
            border: Border(
                bottom: widget.isBorderBottom
                    ? BorderSide(
                        width: widget.isBorderBottom ? 0.7 : 0,
                        color: AppColors.borderColor)
                    : BorderSide.none),
          ),
      child: Row(
        crossAxisAlignment: widget.maxLines > 1
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          widget.labelText != null
              ? SizedBox(
                  width: widget.labelWidth ?? ScreenUtil().setWidth(65),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: widget.maxLines > 1
                            ? ScreenUtil().setWidth(10)
                            : 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.labelText,
                          style: widget.labelStyle ?? defaultText14,
                        ),
                        widget.showImportant
                            ? Text(
                                '*',
                                style: text15WithFail,
                              )
                            : Text('')
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: widget.labelText != null
                      ? ScreenUtil().setWidth(widget.labelMargin)
                      : 0),
              child: widget.disabled
                  ? GestureDetector(
                      onTap: widget.disableCallBack,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: widget.disabledPadding != null
                                  ? ScreenUtil()
                                      .setWidth(widget.disabledPadding)
                                  : 0),
                          child: Text(
                            widget.hindText,
                            style: widget.hindStyle != null
                                ? widget.hindStyle
                                : text16WithB,
                          ),
                        ),
                      ))
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              platform: TargetPlatform.android,
                            ),
                            child: TextField(
                                autofocus: _autoFocus,
                                focusNode: _myFocus,
                                controller: _controller,
                                textInputAction: widget.textInputAction,
                                onSubmitted: widget.onSubmitted,
                                maxLength: widget.maxLength,
                                maxLengthEnforced: true,
                                style: widget.style != null
                                    ? widget.style
                                    : defaultText14,
                                maxLines: widget.maxLines,
                                textAlign: widget.textAlign != null
                                    ? widget.textAlign
                                    : TextAlign.left,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: widget.hindText,
                                    counterText: '',
                                    fillColor: widget.fillColor ?? Colors.white,
                                    filled:
                                        widget.fillColor != null ? true : false,
                                    hintStyle: widget.hindStyle != null
                                        ? widget.hindStyle
                                        : text16WithB,
                                    suffixIcon: widget.showClear &&
                                            _hasdeleteIcon
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _inputText = "";
                                                _hasdeleteIcon =
                                                    (_inputText.isNotEmpty);
                                              });
                                              _controller.clear();
                                              if (widget.clear != null) {
                                                widget.clear();
                                              }
                                            },
                                            child: Image.asset(Utils.wrapAssets(
                                                'input_close.png')),
                                          )
                                        : null,
                                    prefixIcon: widget.prefixIcon),
                                onChanged: (String str) {
                                  RegExp exp = RegExp(r'^[0-9]*$');
                                  if (widget.type == TextInputType.number &&
                                      !widget.canUseEn) {
                                    if (!exp.hasMatch(str)) {
                                      _controller.clear();
                                      return;
                                    }
                                  }
                                  if (widget.maxLength == str.length) {
                                    if (widget.getMaxInput != null) {
                                      widget.getMaxInput(str);
                                      return;
                                    }
                                  }
                                  _inputText = str;
                                  setState(() {
                                    _hasdeleteIcon = (_inputText.isNotEmpty);
                                  });
                                  widget.onChange(str);
                                },
                                keyboardType: widget.type == null
                                    ? TextInputType.text
                                    : widget.type,
                                obscureText: widget.isPawssWord != null
                                    ? widget.isPawssWord && _showPass
                                    : false),
                          ),
                        ),
                        widget.suffix != null ? widget.suffix : Container(),
                        widget.isPawssWord != null && widget.isPawssWord
                            ? (_showPass
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showPass = false;
                                      });
                                    },
                                    child: Image.asset(Utils.wrapAssets(
                                        'login_code_hide.png')),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _showPass = true;
                                      });
                                    },
                                    child: Image.asset(Utils.wrapAssets(
                                        'login_code_show.png')),
                                  ))
                            : Container()
                      ],
                    ),
            ),
          ),
          widget.showVerify != null && widget.showVerify
              ? ButtonRadius(
                  width: widget.verifyWidth != null ? widget.verifyWidth : 90,
                  height:
                      widget.verifyHeight != null ? widget.verifyHeight : 26,
                  borderRadius: 15,
                  text: sendingCode ? sendingText : '获取验证码',
                  borderColor: widget.hasSendCode
                      ? sendingCode
                          ? AppColors.textColorSecondary
                          : AppColors.themeColor
                      : AppColors.textColorSecondary,
                  textStyle: widget.hasSendCode
                      ? sendingCode
                          ? text14With9
                          : themeText14
                      : text14With9,
                  onTap: () {
                    if (!widget.hasSendCode) return;
                    if (!sendingCode) {
                      // 发送
                      RegExp exp = RegExp(
                          r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
                      if (widget.tel != null && widget.tel.length == 11) {
                        widget.sendCode();
                        setState(() {
                          sendingCode = true;
                        });
                        clockTime();
                      } else {
                        Utils.showToast('输入的手机号不正确');
                      }
                    }
                  },
                )
              : Container(),
          widget.lastIcon != null
              ? GestureDetector(
                  onTap: widget.lastIconClick,
                  child: widget.lastIcon,
                )
              : Container()
        ],
      ),
    );
  }
}
