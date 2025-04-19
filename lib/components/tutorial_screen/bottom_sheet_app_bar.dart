
import 'package:animate_do/animate_do.dart';
import 'package:calorie/getx/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

AppBar appBar(BuildContext context, SettingsController settingsController) {
  return AppBar(
    backgroundColor: Get.theme.scaffoldBackgroundColor,
    title: Container(
      width: 150,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: const Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColorLight),
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          settingsController.changeLang(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.translate,
              size: 20,
            ),
            Text(
              'Language'.tr,
              style: const TextStyle(fontSize: 16),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            settingsController.isDarkMode =
                settingsController.isDarkMode! ? false : true;
            GetStorage().write(
                'isDarkMode', settingsController.isDarkMode! ? true : false);
            settingsController.update();
          },
          icon: Icon(settingsController.isDarkMode!
              ? Icons.dark_mode
              : Icons.light_mode)),
    ],
  );
}

Row bottomSheet(BuildContext context, PageController pageController,
    SettingsController settingsController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      GetBuilder<SettingsController>(builder: (controller) {
        return FadeOut(
          duration: const Duration(milliseconds: 250),
          animate: controller.seletedIndex == 2 ? true : false,
          child: TextButton(
              onPressed: controller.seletedIndex == 2
                  ? null
                  : () {
                      settingsController.skipButton(pageController);
                    },
              child: Text(
                'skip'.tr,
                style: TextStyle(color: Theme.of(context).primaryColor),
              )),
        );
      }),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i <= 2; i++)
              GetBuilder<SettingsController>(builder: (c) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linearToEaseOut,
                  margin: const EdgeInsets.all(2),
                  height: 6,
                  width: i == c.seletedIndex ? 24 : 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: i == c.seletedIndex
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                );
              }),
          ],
        ),
      ),
      GetBuilder<SettingsController>(builder: (controller) {
        return FadeOut(
          duration: const Duration(milliseconds: 250),
          animate: controller.seletedIndex == 2 ? true : false,
          child: IconButton(
              onPressed: controller.seletedIndex == 2
                  ? null
                  : () {
                      pageController.animateToPage(
                          (pageController.page! + 1).round(),
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear);
                    },
              icon: const Icon(
                Icons.arrow_forward,
              )),
        );
      }),
    ],
  );
}
