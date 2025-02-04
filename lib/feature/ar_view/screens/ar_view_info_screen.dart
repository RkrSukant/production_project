import 'package:flutter/material.dart';
import 'package:furnihome_ar/feature/ar_view/model/ar_info_model.dart';
import 'package:furnihome_ar/feature/ar_view/screens/component/ar_info_page_content.dart';
import 'package:furnihome_ar/feature/ar_view/screens/component/ar_info_page_indicator.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';

class ARViewInfoScreen extends StatefulWidget {
  const ARViewInfoScreen({Key? key}) : super(key: key);

  @override
  State<ARViewInfoScreen> createState() => _ARViewInfoScreenState();
}

class _ARViewInfoScreenState extends State<ARViewInfoScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<ARInfoModel> infoPages = [
    ARInfoModel(
        image:
            "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/ar-info%2FAr-info-detecting-plane.jpg?alt=media&token=6d1539c8-f7ec-43b3-9f4c-ac626a6548c8",
        title: "Detecting Planes",
        description:
            "Move your camera in a similar motion as the one shown in the animation. This is done to detect all planes in your environment where the furniture model can be placed."),
    ARInfoModel(
        image:
            "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/ar-info%2FAr-info-plane%20detected.jpg?alt=media&token=f4456607-d779-4f17-9f06-ed994dc27da0",
        title: "Add Furniture Model",
        description:
            "When the animation disappears, a dotted grid will appear over your floor, this is your plane. Tap anywhere on your plane to add the furniture object. You can add multiple objects."),
    ARInfoModel(
        image:
            "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/ar-info%2Far-info-moving.gif?alt=media&token=13ac60cf-7f0a-4102-8a6c-15bb65c68394",
        title: "Moving furniture",
        description:
            "You can tap on the object and a white circle appears below it. Use one finger to drag the furniture around and change its position according to your needs."),
    ARInfoModel(
        image:
            "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/ar-info%2Far-info-rotating.gif?alt=media&token=7e153c01-bec9-4072-8c24-5e108173511a",
        title: "Rotating Furniture",
        description:
            "Similarly, you can tap on the furniture object and when the white circle appears, you can use two fingers to rotate the object as per your needs."),
    ARInfoModel(
        image:
            "https://firebasestorage.googleapis.com/v0/b/furnihome-production-project.appspot.com/o/ar-info%2FAr-info-buttons.png?alt=media&token=0807fd0d-e560-494a-8396-7e9780c3f85d",
        title: "Available Features",
        description:
            "There are currently 3 buttons available on the AR View interface. (1) is to view information on how to use AR View. (2) is to click a picture with the furniture object placed and save it to your gallery. (3) is to delete all Furniture objects placed."),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          color: const AppColors().backGroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacing_16),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      itemCount: infoPages.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ARInfoPageContent(model: infoPages[index]);
                      }),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(infoPages.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(Dimens.spacing_4),
                        child:
                            ARInfoPageIndicator(isActive: index == _pageIndex),
                      );
                    })
                  ],
                )
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
