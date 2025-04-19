import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:calorie/getx/locale.dart';

import 'package:calorie/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (controller) {
          return Obx(
            () => GetMaterialApp(
                locale: controller.initLocale,
                translations: MyLocale(),
                title: 'Calorie',
                theme: ThemeData.light().copyWith(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Color.fromARGB(255, 248, 250, 255),
                    ),
                    primaryColorDark: Colors.black,
                    scaffoldBackgroundColor:
                        const Color.fromARGB(255, 248, 250, 255),
                    primaryColorLight: Colors.white,
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: controller.selectedColor.value,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    textTheme: lightTextTheme(controller.font!),
                    primaryColor: controller.selectedColor.value,
                    bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.transparent)),
                darkTheme: ThemeData.dark().copyWith(
                    primaryColorDark: Colors.white,
                    primaryColorLight: const Color.fromARGB(255, 26, 24, 29),
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                        backgroundColor: controller.selectedColor.value,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    textTheme: darkTextTheme(controller.font!),
                    primaryColor: controller.selectedColor.value,
                    bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Color.fromARGB(0, 66, 25, 25))),
                themeMode:
                    controller.isDarkMode! ? ThemeMode.dark : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: const SplashScreen()),
          );
        });
  }
}
