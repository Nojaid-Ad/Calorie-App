import 'package:animate_do/animate_do.dart';
import 'package:calorie/components/home_screen/food_item_list.dart';
import 'package:calorie/components/home_screen/tile_line.dart';
import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealsList extends StatefulWidget {
  const MealsList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  State<MealsList> createState() => _MealsListState();
}

class _MealsListState extends State<MealsList> {
  v() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        animated = true;
      });
    });
  }

  bool animated = false;
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      v();
    });
  }

  final HomeController homeController = Get.find();
  final SettingsController settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            homeController.meelList.length,
            (index) => Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: FadeIn(
                          animate: animated,
                          delay: const Duration(milliseconds: 100),
                          curve: Curves.easeIn,
                          child: TileLine(
                            index: index,
                          ),
                        )),
                    w(12),
                    Expanded(
                      flex: 15,
                      child: AnimatedContainer(
                        curve: Curves.linearToEaseOut,
                        duration:
                            Duration(milliseconds: 400 + (150 * (index ~/ 2))),
                        transform: Matrix4.translationValues(
                            animated
                                ? 0
                                : settingsController.lang == 'ar'
                                    ? -width
                                    : width,
                            0,
                            0),
                        child: Dismissible(
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.delete_solid,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text('deleting meel'.tr,
                                    style: const TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          key: Key("${homeController.meelList[index]['id']}"),
                          onDismissed: (direction) {
                            homeController.deleteMeel(
                                homeController.meelList[index]['id']);
                          },
                          child: foodListGenerateItem(
                            index: index,
                            mass: homeController.meelList[index]['weight'],
                            id: homeController.meelList[index]['id'],
                            imageUrl: homeController.meelList[index]
                                ['imageUrl'],
                            title: homeController.meelList[index]['title'],
                            calorie: homeController.meelList[index]['calorie'],
                            protien: homeController.meelList[index]['protein'],
                            carps: homeController.meelList[index]['carps'],
                            unit: homeController.meelList[index]['unit'],
                            fat: homeController.meelList[index]['fat'],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
        homeController.meelList.length > 4
            ? IconButton(
                tooltip: 'go up'.tr,
                onPressed: () {
                  widget.scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                },
                icon: const Icon(Icons.expand_less))
            : const SizedBox(
                height: 48,
              ),
        h(16),
      ],
    );
  }
}
