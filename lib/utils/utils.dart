import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';

Widget OnClickWidget({required Function onClick, required Widget child}) {
  return InkWell(
    customBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimens.spacing_16),
    ),
    splashColor: AppColors.grey_rgba_e0e7ff,
    onTap: () {
      onClick();
    },
    child: child,
  );
}

void showToast(String title, bool status) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor:
      (status) ? AppColors.green_rbga_0CCB6B : AppColors.red_rbga_ED3241,
      textColor: AppColors.white_rgba_ffffff,
      fontSize: 16);
}

void showToastInfo(String title) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      textColor: AppColors.white_rgba_ffffff,
      fontSize: 16);
}

void showToastInfoShort(String title) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      textColor: AppColors.white_rgba_ffffff,
      fontSize: 16);
}