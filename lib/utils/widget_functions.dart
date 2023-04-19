import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Future<bool?> flutterToast(String message, bool isSuccess) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: (isSuccess == true)
          ? AppColors.green_rbga_0CCB6B
          : AppColors.red_rbga_ED3241,
      textColor: AppColors.white_rbga_ffffff,
      fontSize: Dimens.text_size_12);
}