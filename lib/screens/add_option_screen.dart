import 'package:calorie/consts.dart';
import 'package:calorie/getx/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddOptionScreen extends StatelessWidget {
  final AddOptionController addMealController = Get.put(AddOptionController());
  final HomeController homeController = Get.find();
  AddOptionScreen({super.key});

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
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
              tooltip: 'back'.tr,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: Text(
            'add choice'.tr,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                h(16),
                textInput(
                    isImage: false,
                    icon: const Icon(
                      Icons.restaurant,
                      size: 20,
                    ),
                    imageUrl: 'protein',
                    controller: addMealController.titleC,
                    hint: 'meel name'.tr,
                    isCenter: false,
                    isNumber: false),
                h(16),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () async {
                    await Get.bottomSheet(Container(
                      height: Get.height * 0.1,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              addMealController.imagePickerCamera();
                            },
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Icon(
                                    Icons.camera,
                                  ),
                                ),
                                h(4),
                                Expanded(child: Text('Camera'.tr))
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              addMealController.imagePickerGallary();
                            },
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Icon(
                                    Icons.image,
                                  ),
                                ),
                                Expanded(child: Text('Gallery'.tr))
                              ],
                            ),
                          )
                        ],
                      ),
                    ));
                  },
                  child: GetBuilder<AddOptionController>(builder: (controller) {
                    return Container(
                      width: width,
                      height: height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Get.theme.primaryColorLight,
                        border: Border.all(color: Get.theme.primaryColor),
                      ),
                      child: controller.image == null
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 40,
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      controller.image!,
                                      fit: controller.isFullScreen
                                          ? BoxFit.cover
                                          : BoxFit.contain,
                                      height: height * 0.25,
                                      width: width,
                                    )),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: controller.changeImageSize,
                                          icon: Icon(controller.isFullScreen
                                              ? Icons.fit_screen
                                              : Icons.fullscreen)),
                                      IconButton(
                                          onPressed: controller.removeImage,
                                          icon: const Icon(Icons.cancel)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    );
                  }),
                ),
                h(16),
                GetBuilder<AddOptionController>(builder: (c) {
                  return unitTextField(
                      hint: c.hint.tr, controller: addMealController.mass);
                }),
                h(8),
                Row(
                  children: [
                    Expanded(
                        child: textInput(
                            isImage: false,
                            icon: const Icon(
                              CupertinoIcons.flame_fill,
                              color: Colors.orange,
                              size: 20,
                            ),
                            imageUrl: 'protein',
                            controller: addMealController.calorie,
                            hint: 'kcal'.tr,
                            isCenter: true,
                            isNumber: true)),
                    w(8),
                    Expanded(
                        child: textInput(
                            isImage: true,
                            imageUrl: 'protein',
                            controller: addMealController.protein,
                            hint: 'itemProtien'.tr,
                            isCenter: true,
                            isNumber: true)),
                  ],
                ),
                h(8),
                Row(
                  children: [
                    Expanded(
                        child: textInput(
                            isImage: true,
                            imageUrl: 'fat',
                            controller: addMealController.fat,
                            hint: 'itemFat'.tr,
                            isCenter: true,
                            isNumber: true)),
                    w(8),
                    Expanded(
                        child: textInput(
                            isImage: true,
                            imageUrl: 'carps',
                            controller: addMealController.carps,
                            hint: 'itemCarps'.tr,
                            isCenter: true,
                            isNumber: true)),
                  ],
                ),
                h(16),
                MaterialButton(
                  minWidth: width,
                  onPressed: () {
                    addMealController.save();
                    homeController.fetchData();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: Get.theme.primaryColor,
                  child: Text(
                    'add'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField textInput(
      {required String hint,
      required bool isImage,
      Icon? icon,
      required bool isCenter,
      required bool isNumber,
      required String imageUrl,
      required TextEditingController controller}) {
    return TextField(
      inputFormatters: hint == 'meel name'.tr
          ? []
          : [
              FilteringTextInputFormatter.digitsOnly, // السماح بالأرقام فقط
            ],
      controller: controller,
      style: Get.textTheme.bodyMedium,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      cursorColor: Get.theme.primaryColor,
      textAlign: !isCenter ? TextAlign.start : TextAlign.center,
      decoration: InputDecoration(
        suffixIcon: isImage
            ? Transform.scale(
                scale: 0.4,
                child: Image.asset(
                  'assets/images/$imageUrl.png',
                  height: 1,
                  width: 1,
                ),
              )
            : icon,
        filled: true, fillColor: Get.theme.primaryColorLight,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // ضبط التباعد
      ),
    );
  }

  TextField unitTextField(
      {required String hint, required TextEditingController controller}) {
    return TextField(
      inputFormatters: hint == 'meel name'.tr
          ? []
          : [
              FilteringTextInputFormatter.digitsOnly,
            ],
      controller: controller,
      style: Get.textTheme.bodyMedium,
      cursorColor: Get.theme.primaryColor,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: Container(
          padding: const EdgeInsets.all(8),
          height: 50,
          width: width * 0.325,
          child: DropdownButtonFormField<String>(
            iconEnabledColor: Colors.white,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: Get.textTheme.bodyMedium!.fontFamily,
            ),
            dropdownColor: Get.theme.primaryColor,
            focusColor: Colors.transparent,
            decoration: InputDecoration(
              fillColor: Get.theme.primaryColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Get.theme.primaryColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            borderRadius: BorderRadius.circular(12),
            hint: Text(
              'unit'.tr,
              style: const TextStyle(color: Colors.white),
            ),
            items: [
              DropdownMenuItem(
                onTap: () {},
                value: 'Gram',
                child: Row(
                  children: [
                    const Icon(
                      Icons.scale,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Gram'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                onTap: () {},
                value: 'Mille',
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_drink,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Mille'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem(
                onTap: () {},
                value: 'Piece',
                child: Row(
                  children: [
                    const Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Piece'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            onChanged: addMealController.changeHint,
          ),
        ),
        filled: true, fillColor: Get.theme.primaryColorLight,
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 8), // ضبط التباعد
      ),
    );
  }
}
