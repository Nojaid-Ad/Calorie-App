import 'package:calorie/getx/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TileLine extends StatelessWidget {
  TileLine({super.key, required this.index});
  final int index;
  final SettingsController settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return counters(index, context, settingsController);
  }
}

final ValueNotifier<Map<int, double>> itemHeights = ValueNotifier({});

HomeController homeController = Get.find();
ValueListenableBuilder<Map<int, double>> counters(
    int index, BuildContext context, SettingsController settingsController) {
  return ValueListenableBuilder<Map<int, double>>(
      valueListenable: itemHeights,
      builder: (context, heights, child) {
        final height = heights[index] ?? 0;
        double x = (height * 0.5);
        return Align(
          alignment: settingsController.lang! == 'ar'
              ? Alignment.topRight
              : Alignment.topLeft,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.linear,
                width: 4,
                height: x,
                color: index == 0 ? Colors.transparent : Get.theme.primaryColor,
              ),
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(milliseconds: 250),
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Get.theme.primaryColor),
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 250),
                width: homeController.meelList.length == index + 1 ? 0 : 4,
                height: x,
                color: homeController.meelList.length == index + 1
                    ? Colors.transparent
                    : Get.theme.primaryColor,
              ),
            ],
          ),
        );
      });
}

class MeasureHeight extends StatelessWidget {
  final Widget child;
  final Function(double height) onChange;

  const MeasureHeight({super.key, required this.child, required this.onChange});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      if (box.hasSize) {
        onChange(box.size.height);
      }
    });

    return child;
  }
}
