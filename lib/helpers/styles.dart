import 'package:flutter/cupertino.dart';

const homeColor = Color(0xff06114E);
const secondColor = Color(0xffCD2B50);
const textColor = Color(0xff292A24);
const unSelectIconColor = Color(0xff676767);
const backgroundColor = Color(0xffECECEC);
const priceColor = Color(0xff2CB4FA);

BoxDecoration decoration({required double redias,required Color color}) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(redias),
    );

 paddingSymmetric({required double hor,required double ver}) =>
    EdgeInsets.symmetric(horizontal: hor, vertical: ver);

EdgeInsetsGeometry paddingOnly({required double top, required double bottom,required double  left, required double right}) =>
    EdgeInsets.only(top: top, bottom: bottom, left: left, right: right);

