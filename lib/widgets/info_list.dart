import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';
import 'package:template_flutter/utils/common_utils.dart';

class InfoList extends StatelessWidget {
  /// 标题
  final String title;

  /// 副标题
  final String value;

  /// 上下边距
  final double paddingVertical;

  /// 点击事件
  final Function() onTap;
  final TextStyle titleStyle;
  final TextStyle valueStyle;

  /// 图片链接
  final String imgUrl;

  /// 图片尺寸
  final double imgSize;

  /// 是否有底部border 默认true
  final bool isBorderBottom;

  /// 是否有右箭头 默认true
  final bool isRightArrow;

  /// 左右边距
  final double paddingHorizontal;

  /// 中间文字是否居中
  final bool centerValue;

  /// 是否选择状态
  final bool active;

  /// 自定义左边视图
  final Widget trailing;

  final double height;

  // 长标题
  final bool longTitle;

  final Widget renderWidget;

  final double labelMargin;

  final double centerNum;

  final bool showImportant;

  final int maxLine;

  final bool showTip;

  final Function showTipCallBack;

  InfoList({
    Key key,
    @required this.title,
    this.value,
    this.paddingVertical = 15,
    this.paddingHorizontal = 0,
    this.onTap,
    this.titleStyle,
    this.valueStyle,
    this.imgUrl,
    this.imgSize = 40,
    this.isBorderBottom = true,
    this.centerValue = false,
    this.active = false,
    this.trailing,
    this.isRightArrow = true,
    this.height,
    this.longTitle = false,
    this.renderWidget,
    this.labelMargin,
    this.centerNum,
    this.showImportant = false,
    this.maxLine = 1,
    this.showTip = false,
    this.showTipCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(paddingHorizontal)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height != null ? ScreenUtil().setWidth(height) : null,
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(paddingVertical)),
          decoration: BoxDecoration(
              color: Colors.white,
              border: isBorderBottom
                  ? Border(
                      bottom: BorderSide(
                          color: AppColors.borderColor,
                          width: ScreenUtil().setWidth(0.5)))
                  : null),
          child: Row(
            mainAxisAlignment: centerValue != null && centerValue
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: labelMargin != null
                      ? EdgeInsets.only(right: Utils.getWidth(labelMargin))
                      : EdgeInsets.only(),
                  child: Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: titleStyle ?? defaultText14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      showImportant
                          ? Text(
                              '*',
                              style: text15WithFail,
                            )
                          : Text(''),
                      showTip
                          ? GestureDetector(
                              onTap: showTipCallBack,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: Utils.getWidth(6)),
                                child: Image.asset(
                                    Utils.wrapAssets('show_tip.png')),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                flex: longTitle ? 4 : 0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: centerValue != null && centerValue
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: <Widget>[
                    imgUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(
                                ScreenUtil().setWidth(imgSize / 2))),
                            child: Utils.loadNetworkImage(imgUrl,
                                width: ScreenUtil().setWidth(imgSize),
                                height: ScreenUtil().setWidth(imgSize)),
                          )
                        : trailing != null
                            ? Container(
                                child: trailing,
                              )
                            : Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: centerValue != null && centerValue
                                          ? centerNum != null
                                              ? ScreenUtil().setWidth(centerNum)
                                              : ScreenUtil().setWidth(38)
                                          : 0),
                                  child: Text(
                                    value ?? '',
                                    style: valueStyle ??
                                        (active ? defaultText14 : text14With9),
                                    textAlign: centerValue
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    maxLines: maxLine,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                flex: 1,
                              ),
                    // Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(2))),
                    isRightArrow
                        ? Padding(
                      padding: EdgeInsets.only(left: Utils.getWidth(6)),
                      child: Utils.loadAssetImage('icon_right_arrow',
                          width: ScreenUtil().setWidth(16),
                          height: ScreenUtil().setWidth(16)),
                    )
                        : Text('')
                  ],
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
