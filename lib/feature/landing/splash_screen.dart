import 'dart:async';

import 'package:flutter/material.dart';
import 'package:production_project/anim/anim_scale_transition.dart';
import 'package:production_project/feature/home_screen/home_screen.dart';
import 'package:production_project/utils/dimens.dart';
import 'package:production_project/utils/image_constants.dart';
import 'package:production_project/utils/strings.dart';
import 'package:production_project/utils/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pop(context);
        Navigator.push(context, AnimScaleTransition(page: const HomeScreen()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageConstants.IC_SPLASH_SCREEN),
            fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.spacing_50),
                  child: Image.asset(ImageConstants.IC_APP_LOGO, width: Dimens.spacing_250))),
          const Positioned.fill(
              bottom: 50,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  Strings.bySukant,
                  style: text_7b44c0_16_Regular_w400,
                ),
              )),
        ],
      ),
    );
  }
}
