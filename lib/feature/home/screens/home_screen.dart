import 'package:flutter/material.dart';
import 'package:furnihome_ar/anim/anim_scale_transition.dart';
import 'package:furnihome_ar/common_models/furniture_model.dart';
import 'package:furnihome_ar/di/service_locator.dart';
import 'package:furnihome_ar/feature/components/common_vertical_product_component.dart';
import 'package:furnihome_ar/feature/home/screens/home_viewmodel.dart';
import 'package:furnihome_ar/feature/rooms/model/rooms_model.dart';
import 'package:furnihome_ar/feature/rooms/screens/room_result_screen.dart';
import 'package:furnihome_ar/feature/search/screens/search_screen.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/navigator_drawer_component.dart';
import 'package:furnihome_ar/utils/response_state.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/utils.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel = locator<HomeViewModel>();
  final TextEditingController _searchTextController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    Future.wait([
      viewModel.getFeaturedProducts(),
      viewModel.getLatestProducts(),
      viewModel.getArProducts(),
      viewModel.getRoomList()
    ]);
  }

  void _onRefresh() {
    fetchData();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        drawer: const NavigatorDrawerComponent(),
        appBar: _appBar(),
        body: SmartRefresher(
          enablePullDown: true,
          onRefresh: _onRefresh,
          header: ClassicHeader(),
          controller: _refreshController,
          child: Container(
            color: const AppColors().backGroundColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _searchTextFieldComponent(),
                    addVerticalSpace(Dimens.spacing_16),
                    const Text(
                      Strings.productsWithArView,
                      style: text_7b44c0_14_Medium_w600,
                    ),
                    addVerticalSpace(Dimens.spacing_16),
                    _productHorizontalListViewComponent(
                        Strings.productsWithArView),
                    addVerticalSpace(Dimens.spacing_24),
                    _bannerComponent(ImageConstants.IC_Banner_1),
                    addVerticalSpace(Dimens.spacing_24),
                    const Text(
                      Strings.featuredProducts,
                      style: text_7b44c0_14_Medium_w600,
                    ),
                    addVerticalSpace(Dimens.spacing_16),
                    _productHorizontalListViewComponent(
                        Strings.featuredProducts),
                    addVerticalSpace(Dimens.spacing_24),
                    _bannerComponent(ImageConstants.IC_Banner_2),
                    addVerticalSpace(Dimens.spacing_24),
                    const Text(
                      Strings.ourNewReleases,
                      style: text_7b44c0_14_Medium_w600,
                    ),
                    addVerticalSpace(Dimens.spacing_16),
                    _productHorizontalListViewComponent(Strings.ourNewReleases),
                    addVerticalSpace(Dimens.spacing_24),
                    const Text(
                      Strings.viewByRoom,
                      style: text_7b44c0_14_Medium_w600,
                    ),
                    addVerticalSpace(Dimens.spacing_16),
                    _observeRoomListResponse(),
                    addVerticalSpace(18),
                  ],
                ),
              ),
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
        Strings.home,
        style: text_1f2024_14_Bold_w800,
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          icon: Image.asset(
            ImageConstants.IC_HAMBURGER_MENU_ICON,
            width: Dimens.spacing_20,
            height: Dimens.spacing_20,
            color: AppColors.black_rgba_1f2024,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
    );
  }

  Widget _searchTextFieldComponent() {
    return TextFormField(
      onTap: () {
        Navigator.push(
            context, AnimScaleTransition(page: const SearchScreen()));
      },
      readOnly: true,
      style: text_1f2024_14_Regular_w400,
      controller: _searchTextController,
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
          borderSide: const BorderSide(color: Color.fromRGBO(197, 198, 204, 1)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF006FFD)),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _bannerComponent(String image) {
    return Center(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.spacing_12),
          child: Image.asset(image)),
    );
  }

  Widget _productHorizontalListViewComponent(String type) {
    switch (type) {
      case Strings.featuredProducts:
        return SizedBox(
          height: 300,
          child: _observeFeaturedProducts(),
        );
      case Strings.ourNewReleases:
        return SizedBox(
          height: 300,
          child: _observeLatestProducts(),
        );
      case Strings.productsWithArView:
        return SizedBox(
          height: 300,
          child: _observeArProducts(),
        );
      default:
        return Container();
    }
  }

  Widget _observeArProducts() {
    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.arFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          return const Center(child: CircularProgressIndicator());
        case ResponseState.COMPLETE:
          List<FurnitureModel> furnitures =
              viewModel.arFurnitureListUseCase.data ?? [];
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: furnitures.length,
            itemBuilder: (BuildContext context, int index) {
              return CommonVerticalProductComponent(
                furnitureModel: furnitures[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return addHorizontalSpace(Dimens.spacing_16);
            },
          );
        case ResponseState.ERROR:
          return const Center(child: Text(Strings.something_went_wrong));
        default:
          return Container();
      }
    });
  }

  Widget _observeFeaturedProducts() {
    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.featuredFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          return const Center(child: CircularProgressIndicator());
        case ResponseState.COMPLETE:
          List<FurnitureModel> furnitures =
              viewModel.featuredFurnitureListUseCase.data ?? [];
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: furnitures.length,
            itemBuilder: (BuildContext context, int index) {
              return CommonVerticalProductComponent(
                furnitureModel: furnitures[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return addHorizontalSpace(Dimens.spacing_16);
            },
          );
        case ResponseState.ERROR:
          return const Center(child: Text(Strings.something_went_wrong));
        default:
          return Container();
      }
    });
  }

  Widget _observeLatestProducts() {
    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.latestFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          return const Center(child: CircularProgressIndicator());
        case ResponseState.COMPLETE:
          List<FurnitureModel> furnitures =
              viewModel.latestFurnitureListUseCase.data ?? [];
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: furnitures.length,
            itemBuilder: (BuildContext context, int index) {
              return CommonVerticalProductComponent(
                furnitureModel: furnitures[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return addHorizontalSpace(Dimens.spacing_16);
            },
          );
        case ResponseState.ERROR:
          return const Center(child: Text(Strings.something_went_wrong));
        default:
          return Container();
      }
    });
  }

  Widget _observeRoomListResponse() {
    return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.latestFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          return const Center(child: CircularProgressIndicator());
        case ResponseState.COMPLETE:
          List<RoomModel> rooms = viewModel.homeRoomListUseCase.data ?? [];
          return _viewByRoomComponent(rooms);
        case ResponseState.ERROR:
          return const Center(child: Text(Strings.something_went_wrong));
        default:
          return Container();
      }
    });
  }

  Widget _viewByRoomComponent(List<RoomModel> roomList) {
    return Center(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent:
              ((MediaQuery.of(context).size.width - Dimens.spacing_48) / 2) *
                  (3 / 5),
          mainAxisSpacing: Dimens.spacing_6,
          crossAxisSpacing: Dimens.spacing_8,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: roomList.length,
        itemBuilder: (BuildContext context, int index) {
          return _roomGridComponent(roomList[index]);
        },
      ),
    );
  }

  Widget _roomGridComponent(RoomModel model) {
    return OnClickWidget(
      onClick: () {
        Navigator.push(context,
            AnimScaleTransition(page: RoomResultScreen(roomName: model.title)));
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.spacing_8),
              child: Image.network(
                model.imageName,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.purple_rgba_7b44c0,
                    ),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacing_8),
                    child: Text(
                      model.title,
                      style: text_ffffff_16_Bold_w700,
                      textAlign: TextAlign.center,
                    ))),
          ],
        ),
      ),
    );
  }
}
