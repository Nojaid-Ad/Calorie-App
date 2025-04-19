import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:calorie/screens/settings_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

AppBar customAppBar(
    BuildContext context, SettingsController settingsController) {
  return AppBar(
    forceMaterialTransparency: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Get.theme.scaffoldBackgroundColor,
    title: Row(
      children: [
        Image.asset(
          'assets/images/calorie.png',
          width: 35,
          height: 35,
        ),
        Text(
          'title'.tr,
          style: const TextStyle(fontSize: 18),
        )
      ],
    ),
    toolbarHeight: height * 0.1,
    bottom: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.075),
        child: SizedBox(
          height: 100,
          child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (contoller) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  controller: contoller.scrollController,
                  itemCount: contoller.days.length,
                  itemBuilder: (context, index) {
                    final DateTime day = contoller.days[index];
                    final bool isToday = day.year == DateTime.now().year &&
                        day.month == DateTime.now().month &&
                        day.day == DateTime.now().day;
                    contoller.changeDate(day);
                    return ZoomTapAnimation(
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: isToday
                              ? Theme.of(context).primaryColor.withOpacity(0.75)
                              : contoller.isSelected
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.375)
                                  : Get.theme.primaryColorLight,
                          boxShadow: [
                            if (isToday || contoller.isSelected)
                              BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.115),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            if (!isToday &&
                                !contoller.isSelected &&
                                !settingsController.isDarkMode!)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        margin: const EdgeInsets.fromLTRB(4, 24, 4, 0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            contoller.selectedDate = day;
                            contoller.fetchData();
                            contoller.update();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                contoller.dayOfWeek(day),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isToday
                                      ? Colors.white
                                      : settingsController.isDarkMode!
                                          ? Colors.white54
                                          : Colors.black87,
                                ),
                              ),
                              h(8),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isToday
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${day.day}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isToday
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        )),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton(
            tooltip: 'setting title'.tr,
            onPressed: () {
              Get.to(SettingsScreen(),
                  transition: settingsController.lang == 'ar'
                      ? Transition.leftToRight
                      : Transition.rightToLeft);
            },
            icon: const Icon(Icons.settings)),
      ),
    ],
  );
}
