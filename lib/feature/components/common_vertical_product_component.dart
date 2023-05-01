import 'package:flutter/material.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/product_display/screens/product_detail_screen.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/utils.dart';
import 'package:production_project/utils/widget_functions.dart';

class CommonVerticalProductComponent extends StatefulWidget {
  final FurnitureModel furnitureModel;

  const CommonVerticalProductComponent({Key? key, required this.furnitureModel})
      : super(key: key);

  @override
  State<CommonVerticalProductComponent> createState() =>
      _CommonVerticalProductComponentState();
}

class _CommonVerticalProductComponentState
    extends State<CommonVerticalProductComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Card(
        elevation: 0,
        color: AppColors.purple_light_rgba_f8e2ff,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.spacing_16)),
          side: BorderSide(
              width: Dimens.spacing_0_5, color: AppColors.grey_rgba_E8E9F1),
        ),
        child: OnClickWidget(
            onClick: () {
              Navigator.push(context, AnimScaleTransition(page: ProductDetailScreen(product: widget.furnitureModel)));
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: SizedBox(
                width: Dimens.spacing_164,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Image.asset(
                            ImageConstants.IC_PLACEHOLDER,
                            width: Dimens.spacing_124,
                          ),
                    addVerticalSpace(Dimens.spacing_16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.furnitureModel.title,
                          style: text_2f3036_14_Bold_w700,
                        ),
                        addVerticalSpace(Dimens.spacing_4),
                        Text(
                          widget.furnitureModel.category,
                          style: text_7b44c0_8_regular_w400,
                        ),
                        addVerticalSpace(Dimens.spacing_4),
                        Text(
                          widget.furnitureModel.desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: text_71727a_8_Regular_w400,
                        ),
                      ],
                    ),
                    addVerticalSpace(Dimens.spacing_16),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                          children: [
                        const Text(
                          Strings.nRs,
                          style: text_7b44c0_10_bold_w600,
                        ),
                        Text(
                          widget.furnitureModel.price.toString(),
                          style: text_7b44c0_10_bold_w600,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
