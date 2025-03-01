import 'package:flutter/material.dart';
import 'package:furnihome_ar/feature/ar_view/model/ar_info_model.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';

class ARInfoPageContent extends StatefulWidget {
  const ARInfoPageContent({Key? key, required this.model}) : super(key: key);

  final ARInfoModel model;

  @override
  State<ARInfoPageContent> createState() => _ARInfoPageContentState();
}

class _ARInfoPageContentState extends State<ARInfoPageContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          widget.model.image,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return const SizedBox(
              height: 475,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.purple_rgba_7b44c0,
                ),
              ),
            );
          },
          height: 475,
        ),
        addVerticalSpace(Dimens.spacing_16),
        Text(
          widget.model.title,
          textAlign: TextAlign.center,
          style: text_ar_info_header,
        ),
        addVerticalSpace(Dimens.spacing_8),
        Text(
          widget.model.description,
          textAlign: TextAlign.center,
          style: text_ar_info_detail,
        ),
      ],
    );
  }
}
