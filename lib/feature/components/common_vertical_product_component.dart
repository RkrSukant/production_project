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
      onTap: () {
        Navigator.push(
            context,
            AnimScaleTransition(
                page: ProductDetailScreen(
              product: widget.furnitureModel,
            )));
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
              Navigator.push(
                  context,
                  AnimScaleTransition(
                      page:
                          ProductDetailScreen(product: widget.furnitureModel)));
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacing_16),
                  child: SizedBox(
                    width: Dimens.spacing_164,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Dimens.spacing_12),
                          child: Image.network(
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(color: AppColors.purple_rgba_7b44c0,),
                              );
                            },
                            widget.furnitureModel.imageNames ?? ImageConstants.IC_PLACEHOLDER,
                          ),
                        ),
                        addVerticalSpace(Dimens.spacing_16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.furnitureModel.title ?? "N/A",
                              style: text_2f3036_14_Bold_w700,
                            ),
                            addVerticalSpace(Dimens.spacing_4),
                            Text(
                              widget.furnitureModel.category ?? "N/A",
                              style: text_7b44c0_8_regular_w400,
                            ),
                            addVerticalSpace(Dimens.spacing_4),
                            Text(
                              widget.furnitureModel.desc ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: text_71727a_8_Regular_w400,
                            ),
                          ],
                        ),
                        addVerticalSpace(Dimens.spacing_16),
                        Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
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
                ),
                Visibility(
                  visible: (widget.furnitureModel.arObj != null),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(top: Dimens.spacing_10),
                        child: Image.asset(ImageConstants.IC_AR_CORNER_BANNER, height: 35,)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
