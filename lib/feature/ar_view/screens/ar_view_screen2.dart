import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewScreen2 extends StatefulWidget {
  const ARViewScreen2({Key? key}) : super(key: key);

  @override
  State<ARViewScreen2> createState() => _ARViewScreen2State();
}

class _ARViewScreen2State extends State<ARViewScreen2> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  ARNode? webObjectNode;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onArViewCreated,
          ),
          OnClickWidget(
              onClick: () {
                onWebObjectAtButtonPressed();
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: AppColors.purple_rgba_7b44c0,
                  height: 50,
                  width: 100,
                  child: Text("Add Object"),
                ),
              ))
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white_rbga_ffffff,
      elevation: 0,
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

  void _onArViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManger) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager.onInitialize();
  }

  Future<void> onWebObjectAtButtonPressed() async {
    if (webObjectNode != null) {
      arObjectManager.removeNode(webObjectNode!);
      webObjectNode = null;
    } else {
      double scale =0.2;
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              // "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
              "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.glb?alt=media&token=ad29460d-9306-4d0c-8c78-ebe8a71fb510",
          scale: Vector3(scale, scale, scale));
      bool? didAddWebNode = await arObjectManager.addNode(newNode);
      webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }
}
