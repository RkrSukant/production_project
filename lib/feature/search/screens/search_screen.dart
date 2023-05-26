import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/components/common_vertical_product_component.dart';
import 'package:production_project/feature/rooms/screens/rooms_viewmodel.dart';
import 'package:production_project/feature/search/screens/search_viewmodel.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/response_state.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchViewModel viewModel = locator<SearchViewModel>();
  TextEditingController searchTextController = TextEditingController();
  bool? searchResultVisible;
  bool? noResult;
  List<FurnitureModel> furnitures = [];
  List<FurnitureModel> tempFurnitureList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    searchResultVisible = false;
    noResult = false;
  }

  void fetchData() async {
    Future.wait([viewModel.getFurnitureList()]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: const AppColors().backGroundColor,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: _observeSearchWidget(),
            ),
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
        Strings.search,
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

  Widget _observeSearchWidget() {
    return Consumer<SearchViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.searchListUseCase.state) {
        case ResponseState.LOADING:
          EasyLoading.show();
          return Container();
        case ResponseState.COMPLETE:
          furnitures = viewModel.searchListUseCase.data ?? [];
          EasyLoading.dismiss();
          return Column(children: [
            _searchBarWidget(),
            addVerticalSpace(Dimens.spacing_16),
            Visibility(
                visible:noResult ?? false,
                child: const Center(child: Text(Strings.no_result_found))
            ),
            _searchResultWidget()
          ]);
        case ResponseState.ERROR:
          return const Center(
            child: Text(Strings.something_went_wrong),
          );
        default:
          return const Center(child: Text(Strings.no_data));
      }
    });
  }

  Widget _searchBarWidget() {
    return Column(
      children: [
        TextField(
          autofocus: true,
          style: text_1f2024_14_Regular_w400,
          controller: searchTextController,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
              child: Image.asset(
                ImageConstants.IC_SEARCH_ICON,
                width: 8,
                height: 8,
                color: AppColors.black_rgba_8F9098,
              ),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            hintText: Strings.search,
            hintStyle: text_8f9098_14_Regular_w400,
            filled: true,
            fillColor: const Color.fromRGBO(255, 255, 255, 1),
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: Color.fromRGBO(197, 198, 204, 1)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF006FFD)),
                borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (searchValue) {
            setState(() {
              noResult=false;
              tempFurnitureList = [];
              if(searchValue == ""){
                return;
              }
              for (var furniture in furnitures) {
                if ((furniture.title ?? '').toLowerCase().contains(searchValue.toLowerCase())) {
                  tempFurnitureList.add(furniture);
                }
              }

              if(tempFurnitureList.isEmpty){
                noResult=true;
              }
            });
          },
        ),
        addVerticalSpace(Dimens.spacing_8),
        Visibility(
            visible: searchResultVisible ?? false,
            child: Text(
                "${Strings.search_result_for} \"${searchTextController
                    .text}\""))
      ],
    );
  }

  Widget _searchResultWidget() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (1/1.5),
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.spacing_6,
          crossAxisSpacing: Dimens.spacing_8,
        ),
        shrinkWrap: true,
        itemCount: tempFurnitureList.length,
        itemBuilder: (context, index) {
          return CommonVerticalProductComponent(
            furnitureModel: tempFurnitureList[index],
          );
        });
  }

  void updateSearchResultTextVisibility() {
    if (searchTextController.text == "") {
      searchResultVisible = false;
    } else {
      searchResultVisible = true;
    }
  }
}
