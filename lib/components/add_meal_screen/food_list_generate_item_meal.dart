import 'dart:io';
import 'dart:ui';

import 'package:calorie/screens/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../consts.dart';
import '../../getx/controller.dart';
import '../../screens/edit_option_screen.dart';

Container foodListGenerateItemMeal(
  BuildContext context,
  int index, {
  required String imageUrl,
  required int id,
  required int mass,
  required AddOptionController addOptionController,
  required AddMealController addMealController,
  required String title,
  required int calorie,
  required int protien,
  required int carps,
  required String unit,
  required int fat,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Get.theme.primaryColorLight,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        )
      ],
    ),
    child: Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Get.to(() => ItemScreen(
                  isAddMealScreen: true,
                  mass: mass,
                  id: id,
                  unit: unit,
                  title: title,
                  imageUrl: imageUrl,
                  calorie: calorie,
                  carps: carps,
                  fat: fat,
                  protein: protien,
                ));
          },
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Get.theme.scaffoldBackgroundColor,
                ),
                child: ZoomTapAnimation(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: imageUrl == 'null'
                        ? Center(
                            child: Icon(
                            Icons.restaurant,
                            size: 50,
                            color: Get.theme.primaryColor,
                          ))
                        : Hero(
                            tag: "$id",
                            child: Image.file(
                              File(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        foodItemDataAddMealScreen(
                            title: protien, imageUrl: 'protein'),
                        const Text(
                          ' ',
                        ),
                        foodItemDataAddMealScreen(
                            title: carps, imageUrl: 'carps'),
                        const Text(
                          ' ',
                        ),
                        foodItemDataAddMealScreen(title: fat, imageUrl: 'fat'),
                      ],
                    ),
                  ],
                ),
              ),

              // Calories Section
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$calorie',
                  ),
                  Text(
                    "kcal".tr,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Add to Meal Button
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      overlayColor: Get.theme.primaryColor,
                      side: BorderSide(color: Get.theme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    Get.to(() => EditOptionScreen(
                          id: id,
                          unit: unit,
                          imageUrl: imageUrl,
                        ));
                    addOptionController.titleC.text = title;
                    addOptionController.unit = unit;
                    addOptionController.image =
                        imageUrl == 'null' ? null : File(imageUrl);
                    addOptionController.calorie.text = calorie.toString();
                    addOptionController.protein.text = protien.toString();
                    addOptionController.carps.text = carps.toString();
                    addOptionController.fat.text = fat.toString();
                    addOptionController.mass.text = mass.toString();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Edit Meal'.tr,
                        style: Get.textTheme.labelLarge?.copyWith(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: Get.theme.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              w(8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    addMealController.addMeal(index,
                        title: title,
                        imageUrl: imageUrl,
                        unit: unit,
                        mass: mass,
                        calorie: calorie,
                        protein: protien,
                        carps: carps,
                        fat: fat);
                    HomeController homeController = Get.find();
                    homeController.fetchData();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Get.theme.primaryColor.withOpacity(0.1),
                            border: Border.all(
                                width: 1.5, color: Get.theme.primaryColor)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  w(4),
                                  Text(
                                    'meel added'.tr,
                                    style: TextStyle(
                                        color: Get.theme.primaryColorDark),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      duration: const Duration(seconds: 2),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    elevation: 0,
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Added to Meal'.tr,
                          style: Get.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        addMealController.checkList[index] == true
                            ? Lottie.asset('assets/lottie/checkbox.json',
                                height: 21, width: 21)
                            : const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Row foodItemDataAddMealScreen({required int title, required String imageUrl}) {
  return Row(
    children: [
      Image.asset(
        'assets/images/$imageUrl.png',
        height: 14,
        width: 14,
      ),
      w(2),
      Text(
        '${title.toStringAsFixed(0)}${'g'.tr}',
        style: const TextStyle(fontSize: 11),
      ),
    ],
  );
}
