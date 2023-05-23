import 'package:flutter/material.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';

class ARInfoPageIndicator extends StatelessWidget {
  const ARInfoPageIndicator({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive? Dimens.spacing_10:Dimens.spacing_6,
      width: isActive? Dimens.spacing_12:Dimens.spacing_6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive? AppColors.purple_rgba_7b44c0:AppColors.black_rgba_8F9098,
      ),
    );
  }
}
