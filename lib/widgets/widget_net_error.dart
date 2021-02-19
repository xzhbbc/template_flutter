import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/utils/common_utils.dart';
import 'package:template_flutter/widgets/button_radius.dart';
import 'package:template_flutter/widgets/v_empty_view.dart';

import 'package:template_flutter/constants/common_text_style.dart';

class NetErrorWidget extends StatelessWidget {
  final VoidCallback callback;

  NetErrorWidget({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              Utils.wrapAssets('no_net.png'),
              width: Utils.getWidth(234),
              height: Utils.getWidth(175),
              fit: BoxFit.cover,
            ),
            VEmptyView(40),
            Text(
              '网络异常',
              style: text14With9,
            ),
            VEmptyView(20),
            ButtonRadius(
              width: 80,
              height: 30,
              borderRadius: 20,
              text: '刷新',
              textStyle: themeText14,
              borderColor: AppColors.themeColor,
              background: Colors.white,
              onTap: callback,
            )
          ],
        ),
      ),
    );
  }
}
