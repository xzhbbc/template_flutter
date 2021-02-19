import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:template_flutter/constants/app_colors.dart';
import 'package:template_flutter/constants/common_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static final picker = ImagePicker();

  static void showToast(String msg) {
    if (msg == "" || msg == null) return;
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }

  static double getWidth(double w) {
    return ScreenUtil().setWidth(w);
  }

  static double getSp(double fontSize) {
    return ScreenUtil().setSp(fontSize);
  }

  static String wrapAssets(String url) {
    return "assets/img/" + url;
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/img/$name.$format';
  }

  /// 加载本地资源图片
  static Widget loadAssetImage(String name,
      {num width, num height, BoxFit fit, Color color}) {
    return Image.asset(getImgPath(name),
        height: height, width: width, fit: fit, color: color);
  }

  /// 加载网络图片
  static Widget loadNetworkImage(String imageUrl,
      {String placeholder: "bg_placeholder",
        num width,
        num height,
        BoxFit fit: BoxFit.cover}) {
    return CachedNetworkImage(
      imageUrl: imageUrl == null ? "" : imageUrl,
      placeholder: (context, url) =>
          loadAssetImage(placeholder, height: height, width: width, fit: fit),
      errorWidget: (context, url, error) =>
          loadAssetImage(placeholder, height: height, width: width, fit: fit),
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// 加载带有预览功能的网络图
  static Widget loadNetworkExtendImg(String url,
      {double width, double height, double borderRadius, bool cache = false}) {
    return ExtendedImage.network(
      url,
      width: Utils.getWidth(width),
      height: Utils.getWidth(height),
      fit: BoxFit.fill,
      cache: cache,
      border: Border.all(color: Colors.white, width: 1.0),
//      shape: boxShape,
      borderRadius:
      BorderRadius.all(Radius.circular(Utils.getWidth(borderRadius))),
      //cancelToken: cancellationToken,
    );
  }

  static String fixMoney(int money, {fixNumber: 2}) {
    if (money == null || money == 0) return '0.00';
    return (money / 100).toStringAsFixed(2);
  }

  /// 获取相机图片
  static Future getCameraImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    return image;
  }

  /// 获取相册图片
  static Future getImage(context,
      {int moreSel = 1, bool hasMore = false, bool video = false}) async {
    var result = await PhotoManager.requestPermission();
    if (result) {
      List<AssetEntity> assetList = await PhotoPicker.pickAsset(
        context: context,
        pickType: video ? PickType.onlyVideo : PickType.onlyImage,
        thumbSize: 150,
        disableColor: Colors.grey.shade300,
        themeColor: Colors.black,
        maxSelected: moreSel,
        sortDelegate: SortDelegate.common,
        provider: I18nProvider.chinese,
      );
      if (assetList.length != 0) {
        if (moreSel == 1 && !hasMore) {
          return assetList[0].file;
        } else {
          return assetList;
        }
      }
    } else {
      Utils.showToast('没有权限打开相片，请允许！');
      PhotoManager.openSetting();
    }
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//    return image;
  }

  /// 时间选择器
  static showDatePicker(context,
      {initialDateTime,
        maxDateTime,
        minDateTime,
        onConfirm,
        onCancel,
        type,
        dateFormat}) {
    DateTime _dateTime = DateTime.now();
    DateTime maxDay = _dateTime.add(new Duration(days: 365 * 50)); // 50年
    DatePicker.showDatePicker(context,
        pickerTheme: DateTimePickerTheme(
            showTitle: true,
            confirm: Text('确定', style: TextStyle(color: AppColors.themeColor)),
            cancel: Text('取消',
                style: TextStyle(color: AppColors.textColorSecondary)),
            itemTextStyle: defaultText14),
        minDateTime: minDateTime ?? _dateTime,
        maxDateTime: maxDateTime ?? maxDay,
        initialDateTime: initialDateTime ?? _dateTime,
        dateFormat: dateFormat ?? "yyyy-MMMM-dd",
        //只包含年、月、日
        // dateFormat: 'yyyy年M月d日  EEE,H时:m分',
        pickerMode: type ?? DateTimePickerMode.date,
        locale: DateTimePickerLocale.zh_cn, onCancel: () {
          // debugPrint("onCancel");
          Navigator.maybePop(context);
          if (onCancel != null) {
            onCancel();
          }
        }, onConfirm: (dateTime, List<int> index) {
          onConfirm(dateTime);
        });
  }

  // 城市选择机
  static Future showAddressPicker(BuildContext context,
      {String locationCode = '440100'}) async {
    Result result = await CityPickers.showCityPicker(
      context: context,
      height: ScreenUtil().setWidth(250),
      cancelWidget: Text('取消', style: text14With9),
      confirmWidget: Text('确定', style: themeText14),
      locationCode: locationCode,
    );
    if (result != null) {
      String addressStr =
          result.provinceName + ' ' + result.cityName + ' ' + result.areaName;
      return {
        "address": addressStr,
        "result": result,
      };
    }
  }

  // 将文本复制到粘贴板
  static void copyText(String text, {bool toast = true}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (toast) {
      showToast('复制成功！');
    }
  }

  // 取出粘贴板文本
  static Future<String> getCopyText() async {
    var get = await Clipboard.getData('text/plain');
    return get.text;
  }

  // 格式化时间
  static String formatDate(int time,
      {bool noTime = false, bool justMonth = false}) {
    if (time == null) return '';
    String date = DateTime.fromMillisecondsSinceEpoch(time).toString();
    date = date.split('.')[0];
    if (noTime) {
      date = date.split(' ')[0];
    }
    if (justMonth) {
      date = '${date.split('-')[1]}-${date.split('-')[2]}';
    }
    return date;
  }

  static String checkDayFormat(int time) {
    var today = DateTime.now();
    var todayNum = today.millisecondsSinceEpoch;
    var dateDiff = todayNum - time;
    var lookDay = DateTime.fromMillisecondsSinceEpoch(time);
    String date = lookDay.toString();
    String hasDate = date.split('.')[0];
    date = hasDate.split(' ')[1];

    var dayDiff = (dateDiff / (24 * 3600 * 1000)).floor(); //计算出相差天数
    var leave1 = dateDiff % (24 * 3600 * 1000); //计算天数后剩余的毫秒数
    var hours = (leave1 / (3600 * 1000)).floor();
    if (dayDiff <= 0) {
      return date;
    }
    if (dayDiff < 1) {
      return '昨天 $date';
    } else if (dayDiff < 7) {
      return '周${_coverWeek(lookDay.weekday)} $date';
    } else {
      return hasDate;
    }
  }

  static String _coverWeek(int week) {
    if (week == 1) {
      return '一';
    } else if (week == 2) {
      return '二';
    } else if (week == 3) {
      return '三';
    } else if (week == 4) {
      return '四';
    } else if (week == 5) {
      return '五';
    } else if (week == 6) {
      return '六';
    } else if (week == 7) {
      return '七';
    }
    return '';
  }

  static launchUrlUtil(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showToast('无法打开第三方应用');
    }
  }

  static String getRandomString() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnm';
    int strLength = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strLength; i++) {
// right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  static int getRandomNumber() {
    String alphabet = '1234567890';
    int strLength = 5;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strLength; i++) {
// right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return int.parse(left);
  }
}