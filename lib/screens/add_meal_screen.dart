import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:calorie/screens/add_option_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../components/add_meal_screen/food_list_generate_item_meal.dart';

class AddMealScreen extends StatelessWidget {
  final AddMealController addMealController = Get.put(AddMealController());
  final TextEditingController searchController = TextEditingController();
  final SettingsController settingsController = Get.find();
  final AddOptionController addOptionController =
      Get.put(AddOptionController());
  AddMealScreen({super.key});

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
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.06),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                margin: EdgeInsets.only(top: height * 0.01),
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColorLight,
                  borderRadius: BorderRadius.circular(55),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GetBuilder<HomeController>(
                    init: HomeController(),
                    builder: (controller) {
                      return TextField(
                        controller: searchController,
                        style: TextStyle(
                            color: settingsController.isDarkMode!
                                ? Colors.white
                                : Colors.black),
                        onChanged: addMealController.onChangedTextField,
                        autofocus: false,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                if (searchController.text.isNotEmpty) {
                                  searchController.clear();
                                  addMealController.fetchData('default');
                                }
                              },
                              icon: const Icon(Icons.cancel)),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintText: 'hint text field'.tr,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Get.theme.primaryColorLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          forceMaterialTransparency: true,
          toolbarHeight: height * 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) => addMealController.fetchData(value),
              tooltip: 'filter'.tr,
              icon: const Icon(Icons.filter_list),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  enabled: false,
                  child: Text(
                    'filter by'.tr, // أو 'Filter by'
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Smaller font size
                      color: Colors.white,
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'default',
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Adjusts row size to fit contents
                    children: [
                      const Icon(
                        Icons.sort,
                        size: 12, // Smaller icon size
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Default'.tr,
                        style:
                            const TextStyle(fontSize: 12), // Smaller text size
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'title',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.sort_by_alpha,
                        size: 12, // Smaller icon size
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Title'.tr,
                        style:
                            const TextStyle(fontSize: 12), // Smaller text size
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'calorie',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.flame_fill,
                        color: Colors.orange,
                        size: 12, // Smaller icon size
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Calorie'.tr,
                        style:
                            const TextStyle(fontSize: 12), // Smaller text size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          leading: IconButton(
              tooltip: 'back'.tr,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: Text(
            'add meal'.tr,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.off(() => AddOptionScreen(), transition: Transition.downToUp);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        floatingActionButtonLocation: settingsController.lang == 'ar'
            ? FloatingActionButtonLocation.startFloat
            : FloatingActionButtonLocation.endFloat,
        body: Obx(
          () => addMealController.meelList.isEmpty
              ? searchController.text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Lottie.asset('assets/lottie/search.json',
                                height: 50, width: 50),
                            const SizedBox(height: 8),
                            Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(children: [
                                  TextSpan(
                                    text: "${'no data meal'.tr} ",
                                  ),
                                  TextSpan(
                                    text: searchController.text,
                                    style: TextStyle(
                                        color: Get.theme.primaryColor),
                                  )
                                ])),
                          ]),
                    )
                  : Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'no option'.tr,
                      ),
                    )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                  itemCount: addMealController.meelList.length,
                  itemBuilder: (context, index) => Dismissible(
                        background: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(8.0),
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
                              const SizedBox(width: 8),
                              Text('deleting meel'.tr,
                                  style: const TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        key: Key("${addMealController.meelList[index]['id']}"),
                        onDismissed: (direction) {
                          addMealController.deleteMeel(
                              addMealController.meelList[index]['id']);
                        },
                        child: foodListGenerateItemMeal(
                          addMealController: addMealController,
                          addOptionController: addOptionController,
                          context,
                          index,
                          id: addMealController.meelList[index]['id'],
                          imageUrl: addMealController.meelList[index]
                              ['imageUrl'],
                          title: addMealController.meelList[index]['title'],
                          calorie: addMealController.meelList[index]['calorie'],
                          protien: addMealController.meelList[index]['protein'],
                          carps: addMealController.meelList[index]['carps'],
                          unit: addMealController.meelList[index]['unit'],
                          mass: addMealController.meelList[index]['weight'],
                          fat: addMealController.meelList[index]['fat'],
                        ),
                      )),
        ),
      ),
    );
  }

  // Helper widget for nutrition items
}
