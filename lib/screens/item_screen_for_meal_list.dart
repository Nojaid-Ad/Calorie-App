import 'dart:io';

import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ItemScreenForMealList extends StatelessWidget {
  final SettingsController settingsController = Get.find();
  final HomeController homeController = Get.find();
  final AddMealController addMealController = Get.put(AddMealController());
  getUnitString(String unitString) {
    switch (unitString) {
      case 'Piece':
        return 'Piece'.tr;
      case 'Gram':
        return 'Gram'.tr;
      case 'Mille':
        return 'Mille'.tr;
      default:
        return 'unit'.tr;
    }
  }

  Widget getUnit(String unit) {
    if (unit == 'Piece') {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.075),
                blurRadius: 6,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(16),
            color: Get.theme.primaryColorLight),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  homeController.descressMass();
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                )),
            const SizedBox(
              width: 2,
            ),
            GetBuilder<HomeController>(builder: (context) {
              return Obx(() => Text(
                    '${homeController.mass.value} ${getUnitString(unit)}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ));
            }),
            const SizedBox(
              width: 2,
            ),
            IconButton(
                onPressed: () {
                  homeController.incressMass();
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                )),
          ],
        ),
      );
    } else {
      return Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.075),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(16),
              color: Get.theme.primaryColorLight),
          width: 150,
          child: TextField(
              controller: homeController.textMass,
              onChanged: homeController.onTextChange,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // السماح بالأرقام فقط
              ],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: settingsController.isDarkMode!
                      ? Colors.white
                      : Colors.black),
              cursorColor: Get.theme.primaryColor,
              decoration: InputDecoration(
                hintText: '1',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        unit == 'Gram' ? Icons.scale : Icons.local_drink,
                        size: 17.5,
                        color: unit == 'Gram' ? Colors.yellow : Colors.blue,
                      ),
                      w(4),
                      Text(
                        getUnitString(unit),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.transparent)),
              )));
    }

    // return Container(
    //     padding: const EdgeInsets.all(8),
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(15),
    //         color: Get.theme.primaryColorLight),
    //     child: Row(
    //       children: [
    //         w(16),
    //         Text(
    //           '$mass ${getUnitString(unit)}',
    //           style: const TextStyle(fontSize: 16),
    //         ),
    //         w(16),
    //       ],
    //     ));
  }

  final String title;
  final String imageUrl;
  final int calorie;
  final int protein;
  final int carps;
  final int id;
  final int fat;
  final String unit;
  final int mass;
  final bool isAddMealScreen;

  ItemScreenForMealList(
      {super.key,
      required this.isAddMealScreen,
      required this.id,
      required this.mass,
      required this.title,
      required this.unit,
      required this.imageUrl,
      required this.calorie,
      required this.carps,
      required this.fat,
      required this.protein});

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
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Get.theme.primaryColor,
              minWidth: width,
              height: height * 0.05,
              onPressed: () {
                int weight = homeController.getUnitNumber(unit) == 0
                    ? homeController.mass.value
                    : homeController.getWeight();

                homeController.updateItemScreenMeal(
                  id,
                  (calorie / mass * weight).toInt(),
                  (protein / mass * weight).toInt(),
                  (carps / mass * weight).toInt(),
                  (fat / mass * weight).toInt(),
                  unit,
                  context,
                );

                Get.back();
              },
              child: Text(
                "save".tr,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              )),
        ),
        body: Stack(
          children: [
            Container(
              color: Get.theme.primaryColorLight,
              height: height * 0.5,
              child: imageUrl == 'null'
                  ? Center(
                      child: Hero(
                      tag: "$id",
                      child: Icon(
                        Icons.restaurant,
                        color: Get.theme.primaryColor,
                        size: 50,
                      ),
                    ))
                  : Hero(
                      tag: "$id",
                      child: Image.file(
                        File(
                          imageUrl,
                        ),
                        height: height * 0.45,
                        width: width,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * 0.45,
                  ),
                  Container(
                    height: height * 0.55,
                    width: width,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.075),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        color: Get.theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title.length < 10
                                  ? title
                                  : "${title.substring(0, 10)}...",
                              style: Get.textTheme.headlineMedium!.copyWith(
                                  fontSize: 24,
                                  color: settingsController.isDarkMode!
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            getUnit(unit)
                          ],
                        ),
                        h(8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Get.theme.primaryColorLight,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.075),
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.flame_fill,
                                color: Colors.orange,
                              ),
                              w(16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("kcal".tr,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Get.theme.hintColor)),
                                  Obx(
                                    () => Text(
                                      textAlign: TextAlign.start,
                                      (unit == 'Piece'
                                              ? calorie /
                                                  mass *
                                                  homeController.mass.value
                                              : calorie /
                                                  mass *
                                                  homeController.getWeight())
                                          .toStringAsFixed(0),
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.4),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        h(8),
                        Row(
                          children: [
                            Expanded(
                              child: nutrition(
                                  title: 'itemProtien',
                                  value: protein,
                                  imageUrl: 'protein'),
                            ),
                            w(8),
                            Expanded(
                              child: nutrition(
                                  title: 'itemCarps',
                                  value: carps,
                                  imageUrl: 'carps'),
                            ),
                            w(8),
                            Expanded(
                              child: nutrition(
                                  title: 'itemFat',
                                  value: fat,
                                  imageUrl: 'fat'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Get.theme.primaryColorLight),
                    child: IconButton(
                        tooltip: 'back'.tr,
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  IconButton(
                      onPressed: () {
                        isAddMealScreen
                            ? homeController.deleteMealFromAddMealScreen(id)
                            : homeController.deleteMeel(id);
                        if (isAddMealScreen) {
                          addMealController.fetchData('default');
                        }
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container nutrition(
      {required String title, required int value, required String imageUrl}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Get.theme.primaryColorLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.075),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/$imageUrl.png',
            height: 20,
            width: 20,
          ),
          w(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr,
                  style: TextStyle(fontSize: 10, color: Get.theme.hintColor)),
              Obx(
                () => Text(
                  textAlign: TextAlign.start,
                  "${(unit == 'Piece' ? value / mass * homeController.mass.value : value / mass * homeController.getWeight()).toStringAsFixed(0)}${'g'.tr}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
