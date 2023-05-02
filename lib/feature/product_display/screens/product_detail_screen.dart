import 'package:flutter/material.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/screens/category_result_screen.dart';
import 'package:production_project/feature/product_display/screens/product_detail_viewmodel.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/utils.dart';
import 'package:production_project/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final FurnitureModel product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailViewModel viewModel = locator<ProductDetailViewModel>();

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   Future.wait([]);
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Container(
              color: const AppColors().backGroundColor,
              child: _productDetailWidget(widget.product)),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white_rbga_ffffff,
      elevation: 0,
      title: const Text(
        Strings.categories,
        style: text_1f2024_14_Bold_w800,
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Image.asset(
            ImageConstants.IC_BACK_ICON,
            width: Dimens.spacing_20,
            height: Dimens.spacing_20,
            color: AppColors.black_rgba_1f2024,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }),
    );
  }

  Widget _productDetailWidget(FurnitureModel product) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacing_14),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.purple_light_rgba_f8e2ff,
          borderRadius: BorderRadius.circular(Dimens.spacing_12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productDetailImageWidget(product.imageNames),
              addVerticalSpace(Dimens.spacing_24),
              _getARViewButton(context, product),
              addVerticalSpace(Dimens.spacing_16),
              Text(
                product.title,
                style: text_1f2024_30_Bold_w800,
              ),
              addVerticalSpace(Dimens.spacing_16),
              Text(
                "NRs. ${product.price}",
                style: text_7b44c0_24_Medium_w400,
              ),
              addVerticalSpace(Dimens.spacing_16),
              _categoryWidget(product),
              addVerticalSpace(Dimens.spacing_16),
              _roomsWidget(product),
              addVerticalSpace(Dimens.spacing_16),
              _descriptionWidget(product)
            ],
          ),
        ),
      ),
    );
  }

  Widget _productDetailImageWidget(List<String> imageNames) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.spacing_16),
      child: Image.asset((imageNames.isNotEmpty)
          ? imageNames[0]
          : ImageConstants.IC_PLACEHOLDER),
    );
  }

  Widget _getARViewButton(BuildContext context, FurnitureModel product) {
    return SizedBox(
      width: Dimens.spacing_170,
      height: Dimens.spacing_48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple_rgba_7b44c0,
            elevation: Dimens.spacing_0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.spacing_12),
            )),
        onPressed: () {
          showToast("To AR Screen", true);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              ImageConstants.IC_AR_ICON,
              height: Dimens.spacing_22,
              width: Dimens.spacing_22,
            ),
            const Text(
              Strings.tryItYourself,
              style: text_ffffff_16_Regular_w400,
            )
          ],
        ),
      ),
    );
  }

  Widget _categoryWidget(FurnitureModel product) {
    return Row(
      children: [
        const Text(
          "${Strings.category}:",
          style: text_71727a_14_Light_w300,
        ),
        addHorizontalSpace(Dimens.spacing_8),
        InkWell(
          onTap: () {
            Navigator.push(context, AnimScaleTransition(page: CategoryResultScreen( categoryName: product.category,)));
          },
          child: Text(
            product.category,
            style: text_7b44c0_16_Regular_w500_underline,
          ),
        )
      ],
    );
  }

  Widget _roomsWidget(FurnitureModel product) {
    return Row(
      children: [
        const Text(
          "${Strings.rooms}:",
          style: text_71727a_14_Light_w300,
        ),
        addHorizontalSpace(Dimens.spacing_8),
        Row(
          children: (product.rooms.isEmpty)
              ? [const Text("N/A",style: text_7b44c0_16_Regular_w500_underline)]
              : product.rooms
                  .map((e) => InkWell(
                        onTap: () {
                          showToast("Hi", true);
                        },
                        child: Text(
                          e.toString(),
                          style: text_7b44c0_16_Regular_w500_underline,
                        ),
                      ))
                  .toList(),
        )
      ],
    );
  }

  Widget _descriptionWidget(FurnitureModel product) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: Dimens.spacing_8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "${Strings.description}:", style: text_2f3036_14_Bold_w500,),
          addVerticalSpace(Dimens.spacing_6),
          Text(product.desc, style: text_71727a_14_Light_w300,)
        ],
      ),
    );
  }
}
