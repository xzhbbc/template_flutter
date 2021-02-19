import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';

const double appBarHeight = 44.0;

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 标题
  final String title;

  /// 导航条颜色
  final Color backgroundColor;

  /// 左上角按钮
  final Widget leading;

  /// 操作按钮
  final List<Widget> actions;

  /// 按钮主题
  final IconThemeData iconTheme;

  /// 标题样式
  final TextStyle titleStyle;

  /// 投影
  final double elevation;

  /// 底部视图
  final PreferredSizeWidget bottom;

  final Brightness brightness;

  GlobalAppBar(
      {Key key,
      this.title,
      this.backgroundColor,
      this.leading,
      this.actions,
      this.iconTheme,
      this.titleStyle,
      this.elevation = 0.3,
      this.bottom,
      this.brightness = Brightness.light})
      : preferredSize = Size.fromHeight(appBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  PreferredSize build(BuildContext context) {
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    Widget _leading;

    if (leading != null) {
      _leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: appBarHeight),
        child: leading,
      );
    } else if (canPop) {
      _leading = useCloseButton ? const CloseButton() : const NewBackButton();
    }

    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        iconTheme: iconTheme ?? IconThemeData(color: AppColors.textColor),
        leading: _leading,
        centerTitle: true,
        elevation: elevation,
        actions: actions,
        brightness: brightness,
        title: Text(
          title,
          style: titleStyle ??
              TextStyle(
                color: AppColors.textColor,
                fontSize: FontSizeSp.size18,
                fontWeight: FontWeight.w500,
              ),
        ),
        bottom: bottom,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class NewBackButton extends StatelessWidget {
  const NewBackButton({Key key, this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: Icon(CupertinoIcons.left_chevron),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
