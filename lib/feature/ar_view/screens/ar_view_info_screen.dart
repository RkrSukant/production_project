import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';

class ARViewInfoScreen extends StatefulWidget {
  const ARViewInfoScreen({Key? key}) : super(key: key);

  @override
  State<ARViewInfoScreen> createState() => _ARViewInfoScreenState();
}

class _ARViewInfoScreenState extends State<ARViewInfoScreen> {
  late ArCoreController? arCoreController;

//String localObjectReference;
  ARNode? localObjectNode;

//String webObjectReference;
  ARNode? webObjectNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Container(
          color: const AppColors().backGroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container()
                ],
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
        Strings.ar_view_info,
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
}
