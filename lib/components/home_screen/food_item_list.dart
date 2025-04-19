import 'dart:io';

import 'package:calorie/components/home_screen/tile_line.dart';
import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';

import 'package:calorie/screens/item_screen_for_meal_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final SettingsController settingsController = Get.find();
getUnitString(String unitString) {
  switch (unitString) {
    case 'Piece':
      return 'x';
    case 'Gram':
      return 'Gram'.tr;
    case 'Mille':
      return 'Mille'.tr;
    default:
      return 'unit'.tr;
  }
}

MeasureHeight foodListGenerateItem(
    {required String imageUrl,
    required int mass,
    required String title,
    required int calorie,
    required int protien,
    required int id,
    required int carps,
    required String unit,
    required int index,
    required int fat}) {
  return MeasureHeight(
    onChange: (height) {
      itemHeights.value = {
        ...itemHeights.value,
        index: height,
      };
    },
    child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Get.theme.primaryColorLight,
          boxShadow: [
            BoxShadow(
              color: settingsController.isDarkMode!
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.065),
              blurRadius: 6,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            )
          ]),
      child: InkWell(
        onTap: () {
          homeController.textMass.text = "$mass";
          homeController.weight.value = "$mass";
          homeController.getMass(mass);
          Get.to(() => ItemScreenForMealList(
              isAddMealScreen: false,
              mass: mass,
              id: id,
              unit: unit,
              title: title,
              imageUrl: imageUrl,
              calorie: calorie,
              carps: carps,
              fat: fat,
              protein: protien));
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: imageUrl == 'null'
                  ? Hero(
                      tag: "$id",
                      child: Icon(
                        Icons.restaurant,
                        color: Get.theme.primaryColor,
                      ))
                  : Image.file(
                      File(imageUrl),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
            ),
          ),
          title: Text(
              "${title.length < 40 ? title : "${title.substring(0, 39)}..."} ($mass${getUnitString(unit)})"),
          trailing: Text(
            '$calorie\n${"kcal".tr}',
            textAlign: TextAlign.center,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              foodItemData(title: protien, imageUrl: 'protein'),
              const Text(
                ' ',
              ),
              foodItemData(title: carps, imageUrl: 'carps'),
              const Text(
                ' ',
              ),
              foodItemData(title: fat, imageUrl: 'fat'),
            ],
          ),
        ),
      ),
    ),
  );
}

Expanded foodItemData({required int title, required String imageUrl}) {
  return Expanded(
    child: Row(
      children: [
        Expanded(
          child: Image.asset(
            'assets/images/$imageUrl.png',
            height: 14,
            width: 14,
          ),
        ),
        w(2),
        Text(
          '${title.toStringAsFixed(0)}${'g'.tr}',
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}
