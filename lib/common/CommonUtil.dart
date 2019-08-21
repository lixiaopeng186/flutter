import 'package:flutter/material.dart';

class CommonUtil{



  ///获取屏幕的宽
 static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  ///获取屏幕的高度
  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

}