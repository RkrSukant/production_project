import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/di/service_locator.dart';
import 'package:production_project/feature/rooms/model/rooms_model.dart';
import 'package:production_project/feature/rooms/screens/room_result_screen.dart';
import 'package:production_project/feature/rooms/screens/rooms_viewmodel.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/response_state.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';
import 'package:production_project/utils/utils.dart';
import 'package:provider/provider.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {

  RoomsViewModel viewModel = locator<RoomsViewModel>();

  List<RoomModel> rooms = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await Future.wait([viewModel.getRoomList()]);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsViewModel>(
      create: (BuildContext context) => viewModel,
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          color: const AppColors().backGroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_16),
            child: _observeRoomListResponse(),
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
        Strings.rooms,
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

  Widget _observeRoomListResponse() {
    return Consumer<RoomsViewModel>(builder: (context, viewModel, _) {
      switch (viewModel.roomListUseCase.state) {
        case ResponseState.LOADING:
          EasyLoading.show();
          return Container();
        case ResponseState.COMPLETE:
          EasyLoading.dismiss();
          List<RoomModel> items = viewModel.roomListUseCase.data ?? [];
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
                return _roomGridComponent(
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

  Widget _roomGridComponent(RoomModel model) {
    return OnClickWidget(
      onClick: () {
        Navigator.push(context, AnimScaleTransition(page: RoomResultScreen(roomName: model.title)));
      },
      child: Card(
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.spacing_12),
              child: FadeInImage.assetNetwork(
                placeholder: ImageConstants.IC_LOADING,
                placeholderFit: BoxFit.fitHeight,
                image: model.imageName,
                fit: BoxFit.cover,
              ),
            ),
            Center(child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing_8),
                child: Text(model.title, style: text_ffffff_16_Bold_w700,
                  textAlign: TextAlign.center,))),
          ],
        ),
      ),
    );
  }
}
