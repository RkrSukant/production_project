import 'package:flutter/material.dart';
import 'package:production_project/feature/ar_view/model/ar_info_model.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/widget_functions.dart';

class ARInfoPageContent extends StatefulWidget {
  const ARInfoPageContent(
      {Key? key,
        required this.model})
      : super(key: key);

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