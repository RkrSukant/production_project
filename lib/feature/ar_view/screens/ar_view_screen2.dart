import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/feature/ar_view/screens/Examples/local_web_example.dart';
import 'package:production_project/feature/ar_view/screens/Examples/plane_example.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/utils.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/gestures.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';

class ARViewScreen2 extends StatefulWidget {
  const ARViewScreen2({Key? key}) : super(key: key);

  @override
  State<ARViewScreen2> createState() => _ARViewScreen2State();
}

class _ARViewScreen2State extends State<ARViewScreen2> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  double scale = 1;

  ARNode? nodes;

  ARAnchor? anchors;

  ARNode? objectNode;

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onArViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: OnClickWidget(
          //     onClick: () {
          //       onWebObjectAtButtonPressed();
          //       // Navigator.push(context, AnimScaleTransition(page: LocalWebExample())); //todo remove example
          //       // Navigator.push(context, AnimScaleTransition(page: PlaneArExample())); //todo remove example
          //     },
          //     child: Container(
          //       color: AppColors.purple_rgba_7b44c0,
          //       height: 50,
          //       width: 100,
          //       child: const Text("Add Object"),
          //     ),
          //   ),
          // )
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
    this.arAnchorManager = arAnchorManager;
    this.arSessionManager?.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
        );
    this.arObjectManager?.onInitialize();
    this.arSessionManager?.onPlaneOrPointTap = onPlaneTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
    showToastInfo(Strings.place_object_toast);
  }

  Future<void> onPlaneTapped(List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    var newAnchor =
        ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      anchors = newAnchor;
      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.glb?alt=media&token=ad29460d-9306-4d0c-8c78-ebe8a71fb510",
          scale: Vector3(scale, scale, scale),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddNodeToAnchor =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        nodes = newNode;
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    } else {
      arSessionManager!.onError("Adding Anchor failed");
    }
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    arSessionManager!.onError("Tapped $number node(s)");
  }

  Future<void> onRemoveEverything() async {
    arAnchorManager?.removeAnchor(anchors!);
  }

  Future<void> onWebObjectAtButtonPressed() async {
    if (objectNode != null) {
      arObjectManager?.removeNode(objectNode!);
      objectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          position: Vector3(0.0, -1, -1.5),
          uri:
              "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.glb?alt=media&token=ad29460d-9306-4d0c-8c78-ebe8a71fb510",
          scale: Vector3(scale, scale, scale));
      bool? didAddWebNode = await arObjectManager?.addNode(newNode);
      objectNode = (didAddWebNode!) ? newNode : null;
    }
  }
}
