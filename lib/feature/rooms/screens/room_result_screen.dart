import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/components/common_vertical_product_component.dart';
import 'package:production_project/feature/rooms/screens/rooms_viewmodel.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/response_state.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:provider/provider.dart';

class RoomResultScreen extends StatefulWidget {
  final String roomName;

  const RoomResultScreen({Key? key, required this.roomName})
      : super(key: key);

  @override
  State<RoomResultScreen> createState() => _RoomResultScreenState();
}

class _RoomResultScreenState extends State<RoomResultScreen> {
  RoomsViewModel viewModel = locator<RoomsViewModel>();

  @override
  void initState() {
    super.initState();
    fetchData(widget.roomName);
  }

  void fetchData(String roomName) async {
    Future.wait([viewModel.getRoomFurnitureList(roomName)]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
          appBar: _appBar(),
          body: Padding(
              padding: const EdgeInsets.all(Dimens.spacing_16),
              child: _observeRoomResultResponse())),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.white_rbga_ffffff,
      elevation: 0,
      title: Text(
        widget.roomName,
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

  Widget _observeRoomResultResponse() {
    debugPrint("Here");
    return Consumer<RoomsViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.roomFurnitureListUseCase.state) {
        case ResponseState.LOADING:
          EasyLoading.show();
          return Container();
        case ResponseState.COMPLETE:
          EasyLoading.dismiss();
          List<FurnitureModel> items =
              viewModel.roomFurnitureListUseCase.data ?? [];
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
