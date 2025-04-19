import 'package:calorie/getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts.dart';
import 'food_item_list.dart';

class CalorieCard extends StatelessWidget {
  CalorieCard({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => settingsController.calorie.value <
                        homeController.calorie.value
                    ? Text(
                        ('${(homeController.calorie.value - settingsController.calorie.value).toStringAsFixed(0)}+'),
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4),
                      )
                    : Obx(
                        () => Text(
                          ((settingsController.calorie.value -
                                  homeController.calorie.value)
                              .toStringAsFixed(0)),
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.4),
                        ),
                      ),
              ),
              Obx(
                () => Text(
                  settingsController.calorie.value <
                          homeController.calorie.value
                      ? 'calorie done'.tr
                      : 'Calories\nrestantes'.tr,
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontSize: 12),
                ),
              )
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Obx(
                  () => CircularProgressIndicator(
                    strokeWidth: 7,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    value: settingsController.calorie.value == 0
                        ? 0
                        : homeController.calorie.value /
                            settingsController.calorie.value,
                    color: Colors.orange,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const Icon(
                      CupertinoIcons.flame_fill,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Text(
                            "${homeController.calorie.value}${slash()}",
                            style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Obx(
                          () => Text(
                              settingsController.calorie.value
                                  .toStringAsFixed(0),
                              style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
