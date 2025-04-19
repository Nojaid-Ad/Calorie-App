import 'package:calorie/getx/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts.dart';

class NutrationValue extends StatelessWidget {
  NutrationValue({super.key});
  final HomeController homeController = Get.find();
  final SettingsController settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Obx(
          () => foodNeeds(context,
              imageUrl: 'protein',
              title: settingsController.selectedWeight.value * 1.8 -
                  homeController.protein.value,
              subTitle: 'protien',
              maxValue: settingsController.selectedWeight.value * 1.8,
              currentValue: homeController.protein.value.toDouble(),
              color: Colors.blue),
        )),
        w(8),
        Expanded(
            child: Obx(
          () => foodNeeds(context,
              imageUrl: 'carps',
              title: settingsController.selectedWeight.value * 1.2 -
                  homeController.carps.value,
              subTitle: 'carps',
              maxValue: settingsController.selectedWeight.value * 1.2,
              currentValue: homeController.carps.value.toDouble(),
              color: Colors.green),
        )),
        w(8),
        Expanded(
            child: Obx(
          () => foodNeeds(context,
              imageUrl: 'fat',
              title: settingsController.selectedWeight.value * 0.75 -
                  homeController.fat.value,
              subTitle: 'fat',
              maxValue: settingsController.selectedWeight.value * 0.75,
              currentValue: homeController.fat.value.toDouble(),
              color: Colors.yellow.shade600),
        )),
      ],
    );
  }

  Container foodNeeds(BuildContext context,
      {required String imageUrl,
      required Color color,
      required double title,
      required String subTitle,
      required double maxValue,
      required double currentValue}) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          currentValue >= maxValue
              ? Center(
                  child: Icon(
                  Icons.check,
                  color: color,
                ))
              : Text(
                  '${title.toStringAsFixed(0)}${'g'.tr}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          h(2),
          currentValue >= maxValue
              ? const SizedBox(
                  height: 10,
                )
              : Text(
                  subTitle.tr,
                  style: TextStyle(
                      color: Theme.of(context).hintColor, fontSize: 10),
                ),
          h(16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 65,
                width: 65,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  value: maxValue == 0 ? 0 : currentValue / maxValue,
                  color: color,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/$imageUrl.png',
                    height: 22,
                    width: 22,
                  ),
                  h(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${currentValue.toStringAsFixed(0)}${slash()}",
                        style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        maxValue.toStringAsFixed(0),
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
