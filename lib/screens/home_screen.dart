import 'package:animate_do/animate_do.dart';
import 'package:animated_expandable_fab/expandable_fab/action_button.dart';
import 'package:animated_expandable_fab/expandable_fab/expandable_fab.dart';
import 'package:calorie/components/home_screen/calorie_card.dart';

import 'package:calorie/components/home_screen/meals_list.dart';
import 'package:calorie/components/home_screen/nutration_value.dart';

import 'package:calorie/consts.dart';

import 'package:calorie/getx/controller.dart';
import 'package:calorie/screens/add_meal_screen.dart';
import 'package:calorie/screens/add_option_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../components/home_screen/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final SettingsController settingsController = Get.find();
  final HomeController homeController = Get.put(HomeController());
  final ScrollController scrollController = ScrollController();

  String slash() {
    return settingsController.lang == 'ar' ? '\\' : '/';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
        floatingActionButtonLocation: settingsController.lang == 'ar'
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        floatingActionButton: ExpandableFab(
          closeBackgroundColor: Theme.of(context).cardColor,
          distance: 60,
          openIcon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          closeIcon: Icon(
            Icons.close,
            color: Theme.of(context).primaryColor,
          ),
          children: [
            ActionButton(
              color: Theme.of(context).primaryColor,
              icon: Padding(
                padding: const EdgeInsets.all(11),
                child: Text(
                  "add meal".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              onPressed: () {
                Get.to(() => AddMealScreen(), transition: Transition.downToUp);
              },
            ),
            ActionButton(
              color: Theme.of(context).primaryColor,
              icon: Padding(
                padding: const EdgeInsets.all(11),
                child: Text(
                  'add choice'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
              onPressed: () {
                Get.to(() => AddOptionScreen(),
                    transition: Transition.downToUp);
              },
            ),
          ],
        ),
        appBar: customAppBar(context, settingsController),
        body: ZoomIn(
            child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          children: [
            FadeIn(child: CalorieCard()),
            h(8),
            FadeIn(child: NutrationValue()),
            h(16),
            Obx(() => Text(
                  homeController.meelList.isEmpty ? '' : 'meel'.tr,
                  style: TextStyle(
                      fontSize: homeController.meelList.isEmpty ? 12 : 18),
                )),
            h(8),
            Obx(() => homeController.isLoading.value
                ? SizedBox(
                    height: height * 0.25,
                    width: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  )
                : homeController.meelList.isEmpty
                    ? homeController.selectedDate.day != DateTime.now().day
                        ? SizedBox(
                            height: height * 0.25,
                            child: Center(
                                child:
                                    Lottie.asset('assets/lottie/empty.json')))
                        : ZoomIn(
                            child: SizedBox(
                              height: height * 0.25,
                              child: Center(
                                child: Text(
                                  'no meel'.tr,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                    : MealsList(scrollController: scrollController))
          ],
        )),
      ),
    );
  }
}
