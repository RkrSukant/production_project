import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:production_project/utils/colors.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class ARViewScreen extends StatefulWidget {
  const ARViewScreen({Key? key}) : super(key: key);

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  late ArCoreController? arCoreController;

//String localObjectReference;
  ARNode? localObjectNode;

//String webObjectReference;
  ARNode? webObjectNode;

  @override
  Widget build(BuildContext context) {
    // checkAssetExists();
    checkFileFromUrl();
    return Scaffold(
        appBar: _appBar(context),
        body: Stack(children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                addObject();
              },
              child: const Text("Add Object"),),
          )
        ]));
  }

  void checkAssetExists() async {
    final exists = await rootBundle
        .load("assets/models/chair.gltf")
        .catchError((error) => debugPrint(error));
    debugPrint("Asset exists: $exists");
  }

  void checkFileFromUrl() async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.gltf?alt=media&token=d16f3eda-673f-4eea-a112-970b81e6c118';
    var response = await http.get(Uri.parse(url));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      // The request was successful
      // You can further check the file type or content if needed
      if (response.headers['content-type']!.contains('text/plain')) {
        debugPrint('File is a text file.');
      } else if (response.headers['content-type']!
          .contains('application/pdf')) {
        debugPrint('File is a PDF.');
      }
      // Add more checks for different file types as needed
    } else {
      debugPrint('Failed to retrieve the file. Error: ${response.statusCode}');
    }
  }

  Future<void> addObject() async{
    const double scale = 0.2;
    final ArCoreReferenceNode arNode = ArCoreReferenceNode(
      name: "Model Name",
      objectUrl:
      "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
      // "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.glb?alt=media&token=ad29460d-9306-4d0c-8c78-ebe8a71fb510",
      // "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/chair.gltf?alt=media&token=d16f3eda-673f-4eea-a112-970b81e6c118",
      scale: Vector3(scale, scale, scale),
      position: Vector3(0.0, -1, -1.5),
    );
    await arCoreController?.addArCoreNodeWithAnchor(arNode);
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

  Future<void> _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
  }
}
