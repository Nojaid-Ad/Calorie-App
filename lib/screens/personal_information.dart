import 'package:calorie/getx/controller.dart';
import 'package:calorie/screens/tutrial_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});
  final SettingsController settingsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Info'.tr,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            tooltip: 'back'.tr,
            onPressed: () {
              settingsController.savePersonalInfo();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: TutrialScreen().lastPage(context, isTutorial: false),
    );
  }
}
