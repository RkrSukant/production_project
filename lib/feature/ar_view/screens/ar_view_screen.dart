import 'dart:math';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/utils.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewScreen extends StatefulWidget {
  const ARViewScreen({Key? key}) : super(key: key);

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_16),
            child: OnClickWidget(
                onClick: () {},
                child: Container(
                  color: AppColors.purple_rgba_7b44c0,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.spacing_8),
                    child: Image.asset(
                      ImageConstants.IC_BACK_ICON,
                      color: AppColors.white_rgba_ffffff,
                      width: Dimens.spacing_20,
                      height: Dimens.spacing_20,
                    ),
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
          )
        )
      ],
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    final objBytes = await rootBundle.load('assets/models/couch.obj');
    final mtlBytes = await rootBundle.load('assets/models/couch.obj');

    final objUri = Uri.parse('couch.obj');

    final node = ArCoreReferenceNode(
      name:'couch',
      objectUrl: objUri.toString(),
      scale: vector.Vector3.all(0.1),
      position: vector.Vector3(0,0,-1),
      rotation: vector.Vector4(0,1,0,pi),
    );
  }
}
