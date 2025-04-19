import 'dart:developer';

import 'package:animate_do/animate_do.dart';

import 'package:calorie/components/tutorial_screen/bottom_sheet_app_bar.dart';
import 'package:calorie/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../components/tutorial_screen/first_page.dart';
import '../getx/controller.dart';

// ignore: must_be_immutable
class TutrialScreen extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());
  final PageController pageController = PageController();
  final FocusNode dropdownFocusNode = FocusNode();
  TutrialScreen({super.key});
  List<String> text = [
    'underweight'.tr,
    'normal'.tr,
    'overweight'.tr,
    'obese'.tr,
    'extreme_obese'.tr
  ];

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
          appBar: appBar(context, settingsController),
          bottomSheet: bottomSheet(context, pageController, settingsController),
          body: PageView(
            controller: pageController,
            onPageChanged: settingsController.onPageChanged,
            children: [
              tutrailPage(context,
                  text2: 'Start tracking your calories today'.tr,
                  text: 'Welcome to Calorie'.tr,
                  lottie: 't1'),
              tutrailPage(
                context,
                text: 'Easy To Use and calculate calories'
                    .tr, // Text with font size 18
                lottie: 't2',
                text2: 'Learn how to track your daily calorie intake easily'.tr,
              ),
              lastPage(context, isTutorial: true),
            ],
          )),
    );
  }

  FadeIn lastPage(BuildContext context, {required bool isTutorial}) {
    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          h(isTutorial ? 32 : 0),
          isTutorial
              ? Text(
                  'Info'.tr,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16),
            width: width,
            height: height * 0.5,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        focusNode: dropdownFocusNode,
                        focusColor: Colors.transparent,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Colors.green, width: 1),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8), // ضبط التباعد
                        ),
                        borderRadius: BorderRadius.circular(12),
                        hint: Text('Select Gender'.tr),
                        items: [
                          DropdownMenuItem(
                            onTap: () {},
                            value: 'Male',
                            child: Row(
                              children: [
                                const Icon(Icons.male, color: Colors.blue),
                                const SizedBox(width: 4),
                                Text(
                                  'Male'.tr,
                                  style: TextStyle(
                                      color: Get.textTheme.bodyMedium!.color),
                                ),
                              ],
                            ),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              settingsController.gender.value = 'Female';
                            },
                            value: 'Female',
                            child: Row(
                              children: [
                                const Icon(Icons.female, color: Colors.pink),
                                const SizedBox(width: 4),
                                Text(
                                  'Female'.tr,
                                  style: TextStyle(
                                      color: Get.textTheme.bodyMedium!.color),
                                ),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (val) {
                          settingsController.gender.value = '$val';
                          settingsController.getCalBmi();
                          dropdownFocusNode.unfocus();
                        },
                        value: settingsController.gender.value.isEmpty
                            ? null
                            : settingsController.gender.value,
                      ),
                    ),
                    w(16),
                    Expanded(
                      child: Obx(() => InkWell(
                            onTap: () => showAgeBottomSheet(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green,
                                    width: x.value ? 1.5 : 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    settingsController.selectedAge.value == 200
                                        ? 'age'.tr
                                        : '${'age'.tr} ${settingsController.selectedAge.value}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: settingsController
                                                    .selectedAge.value ==
                                                200
                                            ? Get.theme.hintColor
                                            : Get.textTheme.bodyMedium!.color),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Get.theme.hintColor),
                                ],
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                h(16),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => InkWell(
                            onTap: () => showHeightBottomSheet(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green,
                                    width: y.value ? 1.5 : 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    settingsController.selectedHeight.value ==
                                            275
                                        ? 'height'.tr
                                        : '${'height'.tr} ${settingsController.selectedHeight.value} ${'cm'.tr}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: settingsController
                                                    .selectedHeight.value ==
                                                275
                                            ? Get.theme.hintColor
                                            : Get.textTheme.bodyMedium!.color),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Get.theme.hintColor),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                h(16),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => InkWell(
                            onTap: () => showWeightBottomSheet(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green,
                                    width: z.value ? 1.5 : 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    settingsController.selectedWeight.value ==
                                            310
                                        ? 'weight'.tr
                                        : '${'weight'.tr} ${settingsController.selectedWeight.value} ${'kg'.tr}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: settingsController
                                                    .selectedWeight.value ==
                                                310
                                            ? Get.theme.hintColor
                                            : Get.textTheme.bodyMedium!.color),
                                  ),
                                  Icon(Icons.arrow_drop_down,
                                      color: Get.theme.hintColor),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                h(16),
                const Divider(),
                h(16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          for (int x = 0; x < colors.length; x++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 6,
                                    width: 12,
                                    decoration: BoxDecoration(
                                        color: colors[x],
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  w(8),
                                  Text(
                                    text[x],
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              'Your BMI is'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            h(8),
                            Obx(
                              () => Text(
                                settingsController.bmiValue.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: settingsController.bmiColor()),
                              ),
                            ),
                            h(16),
                            Text(
                              'Caloric needs'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            h(8),
                            Obx(
                              () => Text(
                                settingsController.calorieValue.value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
          !isTutorial
              ? const SizedBox()
              : MaterialButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  onPressed: settingsController.changeSignIn,
                  child: Text(
                    'Get Started'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }

  var x = false.obs;
  void showAgeBottomSheet() {
    x.value = true;
    int tempAge = settingsController.selectedAge.value;

    Get.bottomSheet(
      useRootNavigator: true,
      isDismissible: false,
      Container(
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: FixedExtentScrollController(
                    initialItem: settingsController.selectedAge.value == 200
                        ? 17
                        : settingsController.selectedAge.value - 3),
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  tempAge = index + 3;
                },
                children: List.generate(
                  123,
                  (index) => Center(
                    child: Text(
                      '${index + 3}',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor),
              onPressed: () {
                x.value = false;
                settingsController.selectedAge.value =
                    tempAge == 200 ? 20 : tempAge;
                log("$tempAge");
                settingsController.getCalBmi();
                Get.back();
              },
              child: Text(
                'OK'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  var y = false.obs;
  void showHeightBottomSheet() {
    y.value = true;
    int tempHeight = settingsController.selectedHeight.value;

    Get.bottomSheet(
      useRootNavigator: true,
      isDismissible: false,
      Container(
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: FixedExtentScrollController(
                    initialItem: settingsController.selectedHeight.value == 275
                        ? 125
                        : settingsController.selectedHeight.value - 50),
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  tempHeight = index + 50;
                },
                children: List.generate(
                  201,
                  (index) => Center(
                    child: Text(
                      '${index + 50}  ${'cm'.tr}',
                      style:
                          const TextStyle(fontSize: 22, fontFamily: 'Almarai'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor),
              onPressed: () {
                y.value = false;
                settingsController.selectedHeight.value =
                    tempHeight == 275 ? 175 : tempHeight;
                settingsController.getCalBmi();
                Get.back();
              },
              child: Text(
                'OK'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  var z = false.obs;
  void showWeightBottomSheet() {
    z.value = true;
    int tempWeight = settingsController.selectedWeight.value;

    Get.bottomSheet(
      useRootNavigator: true,
      isDismissible: false,
      Container(
        height: Get.height * 0.4,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: FixedExtentScrollController(
                    initialItem: settingsController.selectedWeight.value == 310
                        ? 40
                        : settingsController.selectedWeight.value - 30),
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  tempWeight = index + 30;
                },
                children: List.generate(
                  271,
                  (index) => Center(
                    child: Text(
                      '${index + 30}  ${'kg'.tr}',
                      style:
                          const TextStyle(fontSize: 22, fontFamily: 'Almarai'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.primaryColor),
              onPressed: () {
                z.value = false;
                settingsController.selectedWeight.value =
                    tempWeight == 310 ? 70 : tempWeight;
                settingsController.getCalBmi();
                Get.back();
              },
              child: Text(
                'OK'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
