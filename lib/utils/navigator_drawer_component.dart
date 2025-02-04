import 'package:flutter/material.dart';
import 'package:furnihome_ar/anim/anim_scale_transition.dart';
import 'package:furnihome_ar/feature/categories/screens/categories_screen.dart';
import 'package:furnihome_ar/feature/rooms/screens/rooms_screen.dart';
import 'package:furnihome_ar/feature/search/screens/search_screen.dart';
import 'package:furnihome_ar/utils/colors.dart';
import 'package:furnihome_ar/utils/dimens.dart';
import 'package:furnihome_ar/utils/image_constants.dart';
import 'package:furnihome_ar/utils/strings.dart';
import 'package:furnihome_ar/utils/text_styles.dart';
import 'package:furnihome_ar/utils/widget_functions.dart';

class NavigatorDrawerComponent extends StatelessWidget {
  const NavigatorDrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white_rgba_ffffff,
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(Dimens.spacing_32),
            Container(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.only(
                  left: Dimens.spacing_24, right: Dimens.spacing_4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: Dimens.spacing_24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.spacing_24),
                        child: SizedBox(
                          height: Dimens.spacing_164,
                          width: Dimens.spacing_164,
                          child: ClipRRect(
                            child: Image.asset(ImageConstants.IC_APP_LOGO),
                            borderRadius:
                            BorderRadius.circular(Dimens.spacing_10),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          icon: Image.asset(
                            ImageConstants.IC_CLOSE_ICON,
                            color: AppColors.purple_rgba_7b44c0,
                            height: Dimens.spacing_24,
                            width: Dimens.spacing_24,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpace(Dimens.spacing_24),
            const Divider(
              height: Dimens.spacing_1,
              thickness: Dimens.spacing_1,
              color: AppColors.grey_rgba_F8F9FE,
            ),
            addVerticalSpace(Dimens.spacing_16),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title: const Text(Strings.categories,
                  style: text_1F2024_16_Regular_w400),
              onTap: () {
                Navigator.pop(context, true);
                Navigator.push(context,
                    AnimScaleTransition(page: const CategoriesScreen()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title:
              const Text(Strings.rooms, style: text_1F2024_16_Regular_w400),
              onTap: () {
                Navigator.pop(context, true);
                Navigator.push(
                    context, AnimScaleTransition(page: const RoomsScreen()));
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: Dimens.spacing_32),
              title: const Text(Strings.search,
                  style: text_1F2024_16_Regular_w400),
              onTap: () {
                Navigator.pop(context, true);
                Navigator.push(
                    context, AnimScaleTransition(page: const SearchScreen()));
              },
            ),
          ],
        ),
        const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(Dimens.spacing_8),
                child: Text("Version 1.0.0")))
      ]),
    );
  }
}
