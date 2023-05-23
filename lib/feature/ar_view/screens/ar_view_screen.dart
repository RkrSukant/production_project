import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/ar_view/screens/ar_view_info_screen.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/utils.dart';
import 'package:production_project/utils/widget_functions.dart';
import 'package:vector_math/vector_math_64.dart';

class ARViewScreen extends StatefulWidget {
  final FurnitureModel furnitureModel;

  const ARViewScreen({Key? key, required this.furnitureModel})
      : super(key: key);

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  double scale = 1;

  ARNode? nodes;

  ARAnchor? anchors;

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ARView(
          onARViewCreated: _onArViewCreated,
          planeDetectionConfig: PlaneDetectionConfig.horizontal,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spacing_16, vertical: Dimens.spacing_32),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple_rgba_7b44c0,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.white_rgba_ffffff,
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.purple_rgba_7b44c0,
                  ),
                  child: IconButton(
                      iconSize: Dimens.spacing_32,
                      onPressed: () {
                        onInfoTapped();
                      },
                      color: AppColors.white_rgba_ffffff,
                      icon: const Icon(Icons.info_outline)),
                ),
                addHorizontalSpace(Dimens.spacing_32),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.purple_rgba_7b44c0,
                  ),
                  child: IconButton(
                      iconSize: Dimens.spacing_48,
                      onPressed: () {
                        onTakeScreenshot();
                      },
                      color: AppColors.white_rgba_ffffff,
                      icon: const Icon(Icons.camera)),
                ),
                addHorizontalSpace(Dimens.spacing_32),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.purple_rgba_7b44c0,
                  ),
                  child: IconButton(
                      iconSize: Dimens.spacing_32,
                      color: AppColors.white_rgba_ffffff,
                      onPressed: () {
                        onRemoveEverything();
                      },
                      icon: const Icon(Icons.delete)),
                ),
              ],
            ),
          ),
        ),
      ],
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
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager?.onInitialize();
    this.arSessionManager?.onPlaneOrPointTap = onPlaneTapped;
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
    showToastInfo(Strings.place_object_toast);
  }

  Future<void> onPlaneTapped(List<ARHitTestResult> hitTestResults) async {
    showToastInfo(Strings.loading_ar_object);
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
          uri: widget.furnitureModel.arObj ??
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

  onPanStarted(String nodeName) {
    debugPrint("Started panning node $nodeName");
    showToastInfoShort(Strings.moving_object);
  }

  onPanChanged(String nodeName) {
    debugPrint("Continued panning node $nodeName");
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    debugPrint("Ended panning node $nodeName");
    final pannedNode = nodes?.name == nodeName;
  }

  onRotationStarted(String nodeName) {
    debugPrint("Started rotating node $nodeName");
    showToastInfoShort(Strings.rotating_object);
  }

  onRotationChanged(String nodeName) {
    debugPrint("Continued rotating node $nodeName");
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    debugPrint("Ended rotating node $nodeName");
    final rotatedNode = nodes?.name == nodeName;
  }

  Future<void> onRemoveEverything() async {
    arAnchorManager?.removeAnchor(anchors!);
  }

  Future<void> onTakeScreenshot() async {
    var image = await arSessionManager!.snapshot();
    if (await Permission.storage.request().isGranted) {
      try {
        final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
        final result = await ImageGallerySaver.saveImage(
            (image as MemoryImage).bytes,
            name: "Furnihome_Image_$timestamp");
        debugPrint(
            "----------------------------------------------> result: $result");
        showToastInfo(Strings.image_saved);
      } catch (e) {
        showToastInfo('Error saving image: $e');
        return;
      }
    } else {
      showToastInfo(Strings.storage_permission_not_granted);
    }
  }

  void onInfoTapped() {
    Navigator.pop(context);
    Navigator.push(context, AnimScaleTransition(page: ARViewInfoScreen()));
  }
}
