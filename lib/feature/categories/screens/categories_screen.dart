import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/categories/model/category_model.dart';
import 'package:production_project/feature/categories/screens/categories_viewmodel.dart';
import 'package:production_project/feature/categories/screens/category_result_screen.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/response_state.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/utils.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  CategoriesViewModel viewModel = locator<CategoriesViewModel>();

  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Future.wait([viewModel.getCategoryList()]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoriesViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          color: const AppColors().backGroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_16),
            child: _observeCategoryListResponse(),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
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

  Widget _observeCategoryListResponse() {
    return Consumer<CategoriesViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.categoryListUseCase.state) {
        case ResponseState.LOADING:
          EasyLoading.show();
          return Container();
        case ResponseState.COMPLETE:
          EasyLoading.dismiss();
          List<CategoryModel> items = viewModel.categoryListUseCase.data ?? [];
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: ((MediaQuery
                    .of(context)
                    .size
                    .width - Dimens.spacing_48) / 2) * (3 / 5),
                mainAxisSpacing: Dimens.spacing_6,
                crossAxisSpacing: Dimens.spacing_8,
              ),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _categoryGridComponent(
                    items[index]);
              }
          );
        case ResponseState.ERROR:
          return const Center(child: Text(Strings.something_went_wrong),);
        default:
          return Container();
      }
    });
  }

  Widget _categoryGridComponent(CategoryModel model) {
    return OnClickWidget(
      onClick: () {
        Navigator.push(context, AnimScaleTransition(page: CategoryResultScreen(categoryModel: model)));
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.spacing_12),
              child: Image.asset(
                model.imageName,
                fit: BoxFit.cover,
              ),
            ),
            Center(child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing_8),
                child: Text(model.categoryName, style: text_ffffff_16_Bold_w700,
                  textAlign: TextAlign.center,))),
          ],
        ),
      ),
    );
  }
}
