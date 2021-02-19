import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/config/application.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';
import 'package:template_flutter/utils/common_utils.dart';

class ButtonRadius extends StatelessWidget {
  final String text;
  final num width;
  final num height;
  final borderRadius;
  final borderColor;
  final TextStyle textStyle;
  final background;
  final Function onTap;
  final Function onLongPress;
  final Function onDoubleTap;
  final Gradient gradient;
  final bool showNum;
  final int number;
  final double borderWidth;

  const ButtonRadius(
      {Key key,
      @required this.text,
      this.width,
      this.height,
      this.background,
      this.borderRadius,
      this.borderColor,
      this.textStyle,
      this.onTap,
      this.onLongPress,
      this.gradient,
      this.onDoubleTap,
      this.showNum = false,
      this.number,
      this.borderWidth = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (onDoubleTap != null) {
          onDoubleTap();
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: width != null
            ? ScreenUtil().setWidth(width)
            : Application.screenWidth - 50,
        height: height != null
            ? ScreenUtil().setWidth(height)
            : ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            color: background != null ? background : Colors.white,
            gradient: gradient,
            border: Border.all(
                color: borderColor != null
                    ? borderColor
                    : background ?? Colors.white,
                width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius != null
                ? ScreenUtil().setWidth(borderRadius)
                : 10.0)),
        child: Center(
          child: showNum
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: Utils.getWidth(115),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.getWidth(10),
                          vertical: Utils.getWidth(10)),
                      child: Text(
                        text,
                        style: textStyle ?? textStyle,
                      ),
                    ),
                    number != null && number != 0
                        ? Positioned(
                            top: 5,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Utils.getWidth(4),
                                  vertical: Utils.getWidth(2)),
                              decoration: BoxDecoration(
                                color: AppColors.failText,
                                borderRadius:
                                    BorderRadius.circular(Utils.getWidth(9)),
                              ),
                              child: Text(
                                '$number',
                                style: text14WithWhite,
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              : Text(
                  text,
                  style: textStyle ?? textStyle,
                ),
        ),
      ),
    );
  }
}
