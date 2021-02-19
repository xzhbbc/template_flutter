import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/utils/common_utils.dart';

class OverImgWidget extends StatelessWidget {
  final String img;
  final double width;
  final BoxFit fit;

  OverImgWidget(this.img, this.width, {this.fit});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: img.startsWith('http')
          ? Utils.loadNetworkImage(img,
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setWidth(width),
              fit: fit)
          : Image.asset(img,
              width: ScreenUtil().setWidth(width),
              height: ScreenUtil().setWidth(width),
              fit: fit),
    );
  }
}
