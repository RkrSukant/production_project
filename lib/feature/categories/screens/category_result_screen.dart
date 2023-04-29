import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/model/category_model.dart';
import 'package:production_project/feature/categories/screens/categories_viewmodel.dart';
import 'package:production_project/feature/components/common_vertical_product_component.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/response_state.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:provider/provider.dart';

class CategoryResultScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryResultScreen({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<CategoryResultScreen> createState() => _CategoryResultScreenState();
}

class _CategoryResultScreenState extends State<CategoryResultScreen> {
  CategoriesViewModel viewModel = locator<CategoriesViewModel>();

  @override
  void initState() {
    super.initState();
    fetchData(widget.categoryModel.categoryName);
  }

  void fetchData(String categoryName) async {
    Future.wait([viewModel.getCategoryFurnitureList(categoryName)]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoriesViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
          appBar: _appBar(),
          body: Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: _observeCategoryResultResponse())),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.white_rbga_ffffff,
      elevation: 0,
      title: Text(
        widget.categoryModel.categoryName,
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

  Widget _observeCategoryResultResponse() {
    debugPrint("Here");
    return Consumer<CategoriesViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.categoryFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          EasyLoading.show();
          return Container();
        case ResponseState.COMPLETE:
          EasyLoading.dismiss();
          List<FurnitureModel> items =
              viewModel.categoryFurnitureListUseCase.data ?? [];
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1/1.5),
                crossAxisCount: 2,
                mainAxisSpacing: Dimens.spacing_6,
                crossAxisSpacing: Dimens.spacing_8,
              ),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CommonVerticalProductComponent(
                  furnitureModel: items[index],
                );
              });
        case ResponseState.ERROR:
          return const Center(
            child: Text(Strings.something_went_wrong),
          );
        default:
          return Container();
      }
    });
  }
}
