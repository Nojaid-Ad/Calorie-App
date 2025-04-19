import 'package:calorie/consts.dart';
import 'package:calorie/screens/personal_information.dart';
import 'package:calorie/sqlite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../getx/controller.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top],
        );
      },
      child: Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            'App Version: v1.0.0'.tr,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 11),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          centerTitle: true,
          title: Text('setting title'.tr),
          automaticallyImplyLeading: false,
          leading: IconButton(
              tooltip: 'back'.tr,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('theme'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 9)),
              h(8),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: settingsController.isDarkMode!
                            ? Colors.grey.shade800
                            : Colors.grey.withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      GetBuilder<SettingsController>(
                          init: SettingsController(),
                          builder: (controller) {
                            return SwitchListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12.5),
                                secondary: Icon(controller.isDarkMode!
                                    ? Icons.dark_mode
                                    : Icons.light_mode),
                                title: Text(
                                  'Dark Mode'.tr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                activeColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                value: controller.isDarkMode!,
                                onChanged: controller.toggleTheme);
                          }),
                      const Divider(
                        height: 8,
                        thickness: 0.25,
                      ),
                      InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () async {
                            Color newColor = await showColorPicker(context,
                                settingsController.selectedColor.value);
                            settingsController.saveColor(newColor);
                          },
                          child: ListTile(
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            leading: const Icon(Icons.color_lens),
                            title: Text('Display Color'.tr),
                          )),
                    ],
                  ),
                ),
              ),
              h(16),
              Text('Text'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 9)),
              h(8),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: settingsController.isDarkMode!
                            ? Colors.grey.shade800
                            : Colors.grey.withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      InkWell(
                        child: GetBuilder<SettingsController>(
                            init: SettingsController(),
                            builder: (controller) {
                              return ListTile(
                                trailing: PopupMenuButton(
                                    elevation: 1,
                                    position: PopupMenuPosition.under,
                                    itemBuilder: (c) => [
                                          PopupMenuItem(
                                            height: 40,
                                            child: Row(
                                              children: [
                                                const Text('🇱🇾'),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text('Arabic'.tr),
                                              ],
                                            ),
                                            onTap: () {
                                              controller.changeLocale('ar');
                                            },
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              controller.changeLocale('en');
                                            },
                                            height: 40,
                                            child: Row(
                                              children: [
                                                const Text('🇺🇸'),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text('English'.tr),
                                              ],
                                            ),
                                          )
                                        ],
                                    child: const Icon(Icons.arrow_drop_down)),
                                leading: const Icon(Icons.translate),
                                title: Text(
                                  'Language'.tr,
                                  style: const TextStyle(fontSize: 14),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              );
                            }),
                      ),
                      const Divider(
                        height: 8,
                        thickness: 0.25,
                      ),
                      InkWell(
                        child: ListTile(
                          trailing: PopupMenuButton(
                              elevation: 1,
                              position: PopupMenuPosition.under,
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                      height: 40,
                                      child: const Text('Roboto'),
                                      onTap: () {
                                        settingsController
                                            .changeFont('Default');
                                      },
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        settingsController
                                            .changeFont('Almarai');
                                      },
                                      height: 40,
                                      child: const Text('Almarai'),
                                    ),
                                  ],
                              child: const Icon(Icons.arrow_drop_down)),
                          leading: const Icon(Icons.font_download),
                          title: Text(
                            'Font Style'.tr,
                            style: const TextStyle(fontSize: 14),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              h(16),
              Text('Application'.tr,
                  style: TextStyle(
                      color: Theme.of(context).dividerColor, fontSize: 9)),
              h(8),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: settingsController.isDarkMode!
                            ? Colors.grey.shade800
                            : Colors.grey.withOpacity(0.5))),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Get.to(() => PersonalInformation());
                          },
                          child: ListTile(
                            subtitle: Text(
                              '📏 Height | ⚖️ Weight | 🎂 Age'.tr,
                              style: const TextStyle(fontSize: 8),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                            leading: const Icon(Icons.account_circle),
                            title: Text('Info'.tr),
                          )),
                      const Divider(
                        thickness: 0.25,
                        height: 8,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.share_solid,
                          ),
                          title: Text(
                            'Share Application'.tr,
                          ),
                        ),
                        onTap: () {},
                      ),
                      const Divider(
                        height: 8,
                        thickness: 0.25,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.star,
                          ),
                          title: Text(
                            "Rate the app on the store".tr,
                          ),
                        ),
                        onTap: () {},
                      ),
                      const Divider(
                        height: 8,
                        thickness: 0.25,
                      ),
                      InkWell(
                        onTap: () {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Icon(Icons.warning_amber_rounded,
                                  color: Colors.red, size: 60),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'are you sure'.tr,
                                    textAlign: TextAlign.center,
                                  ),
                                  h(8),
                                  Text(
                                    'cant go back'.tr,
                                    style: TextStyle(color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      side:
                                          const BorderSide(color: Colors.red)),
                                  onPressed: () {
                                    Get.back(); // فقط إغلاق الـ Dialog
                                  },
                                  child: Text(
                                    'cancel'.tr,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    MySql().deleteApp();
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                  label: Text('yes delete'.tr),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                ),
                              ],
                            ),
                            barrierDismissible:
                                false, // يمنع إغلاق النافذة بالضغط خارجها
                          );
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.delete_solid,
                            color: Colors.red,
                          ),
                          title: Text(
                            'Delete Data'.tr,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              h(32)
            ],
          ),
        ),
      ),
    );
  }

  Future<Color> showColorPicker(
      BuildContext context, Color currentColor) async {
    Color selected = currentColor;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select a Color".tr,
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                selected = color;
              },
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Ok".tr,
                  style: TextStyle(color: selected),
                ),
              ),
            ),
          ],
        );
      },
    );

    return selected;
  }
}
