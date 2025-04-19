import 'dart:io';
import 'dart:ui';

import 'package:calorie/screens/home_screen.dart';
import 'package:calorie/sqlite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddOptionController extends GetxController {
  final TextEditingController titleC = TextEditingController();
  final TextEditingController mass = TextEditingController();
  final TextEditingController calorie = TextEditingController();
  final TextEditingController protein = TextEditingController();
  final TextEditingController fat = TextEditingController();
  final TextEditingController carps = TextEditingController();
  String unit = '';
  File? image;
  upadateMeal(
      {required int id, required String unit, required String imageUrl}) async {
    if (calorie.text.isNotEmpty &&
        mass.text.isNotEmpty &&
        titleC.text.isNotEmpty &&
        unit.isNotEmpty &&
        mass.text != "0" &&
        unit != '') {
      await sql.updateData('''UPDATE option SET 
        title = "${titleC.text}" , 
        imageUrl = "${image == null ? 'null' : image!.path}",
        unit = '$unit',
        weight =  '${int.tryParse(mass.text) ?? 1}',
        calorie = '${int.tryParse(calorie.text) ?? 0}',
        protein =  '${int.tryParse(protein.text) ?? 0}',
        carps = '${int.tryParse(carps.text) ?? 0}',
        fat = '${int.tryParse(fat.text) ?? 0}'
        WHERE id = $id
        ''');
      Get.back();
    } else {
      Get.snackbar('error'.tr, 'error save'.tr);
    }
  }

  MySql sql = MySql();
  Future<void> save() async {
    if (calorie.text.isNotEmpty &&
        mass.text.isNotEmpty &&
        titleC.text.isNotEmpty &&
        unit.isNotEmpty &&
        mass.text != "0" &&
        unit != '') {
      await sql.insertData('''INSERT INTO option(
        title,imageUrl,unit,weight,calorie,protein,carps,fat) 
        VALUES("${titleC.text}",
        '${image != null ? image!.path : 'null'}',
        "$unit",
        '${int.tryParse(mass.text) ?? 1}',
        '${int.tryParse(calorie.text) ?? 0}',
        '${int.tryParse(protein.text) ?? 0}',
        '${int.tryParse(carps.text) ?? 0}',
        '${int.tryParse(fat.text) ?? 0}'
        )
    
''');

      Get.back();
    } else {
      Get.snackbar('error'.tr, 'error save'.tr);
    }
  }

  bool isFullScreen = true;
  void changeImageSize() {
    isFullScreen = !isFullScreen;
    update();
  }

  void removeImage() {
    image = null;
    update();
  }

  Future<void> imagePickerCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);

      Get.back();
      update();
    }
  }

  Future<void> imagePickerGallary() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      Get.back();
      update();
    }
  }

  String hint = '';
  void changeHint(String? value) {
    hint = value!;
    unit = value;
    update();
  }
}

class AddMealController extends GetxController {
  var isLoading = true.obs;
  var meelList = <Map>[].obs;
  List<Map> allMealList = [];
  var checkList = <bool>[].obs;
  checkListAnimation() {
    for (int x = 0; x < meelList.length; x++) {
      checkList.add(false);
    }
  }

  MySql sql = MySql();

  addMeal(int index,
      {required String title,
      required String imageUrl,
      required String unit,
      required int mass,
      required int calorie,
      required int protein,
      required int carps,
      required int fat}) async {
    checkList[index] = true;
    await sql.insertData('''INSERT INTO meel(
        title,imageUrl,unit,weight,calorie,protein,carps,fat,date) 
        VALUES("$title",
        '$imageUrl',
        "$unit",
        '$mass',
        '$calorie',
        '$protein',
        '$carps',
        '$fat',
        '${DateTime.now()}'
        )
    
''');
    await Future.delayed(const Duration(seconds: 2), () {
      checkList[index] = false;
    });
  }

  Future fetchData(String value) async {
    switch (value) {
      case 'calorie':
        allMealList =
            await mySql.readData('SELECT * FROM option ORDER BY calorie DESC');
        break;
      case 'title':
        allMealList =
            await mySql.readData('SELECT * FROM option ORDER BY title');
        break;
      default:
        allMealList = await mySql.readData('SELECT * FROM option');
        break;
    }

    meelList.assignAll(allMealList);
    checkListAnimation();
    isLoading.value = false;
  }

  onChangedTextField(String? value) {
    meelList.clear();
    meelList.addAll(allMealList
        .where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(value!.toLowerCase()))
        .toList());
  }

  Future<void> deleteMeel(int id) async {
    mySql.deleteData('''
                        DELETE FROM option WHERE id = $id
''');
    fetchData('default');
  }

  @override
  void onInit() {
    fetchData('default');

    super.onInit();
  }
}

MySql mySql = MySql();

class HomeController extends GetxController {
  final TextEditingController textMass = TextEditingController();
  getWeight() {
    return int.tryParse(weight.value) ?? 1;
  }

  RxString weight = ''.obs;
  onTextChange(String value) {
    weight.value = value;
  }

  RxInt mass = 0.obs;
  getMass(int realMass) {
    mass.value = realMass;
  }

  getUnitNumber(String unit) {
    return unit == 'Piece' ? 0 : 1;
  }

  updateItemScreenMeal(int id, cc, protein, carps, fat, unit, context) async {
    await mySql.updateData(
        '''UPDATE meel SET weight = ${unit == 'Piece' ? mass.value : getWeight()},calorie=$cc ,protein =$protein , carps =$carps , fat = $fat WHERE id =$id''');
    await fetchData();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Get.theme.primaryColor.withOpacity(0.1),
            border: Border.all(width: 1.5, color: Get.theme.primaryColor)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    "change save".tr,
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
    ));
  }

  incressMass() {
    mass.value++;
  }

  descressMass() {
    if (mass.value > 1) {
      mass.value--;
    }
  }

  var isLoading = true.obs;
  var meelList = <Map>[].obs;
  Future<int> getCalorie() async {
    int b = 0;
    for (int x = 0; x < meelList.length; x++) {
      DateTime itemDate = DateTime.parse(meelList[x]['date']);
      if (itemDate.day == selectedDate.day &&
          itemDate.month == selectedDate.month) {
        b += int.parse(meelList[x]['calorie'].toString());
      }
    }
    return b;
  }

  Future<int> getProtien() async {
    int b = 0;
    for (int x = 0; x < meelList.length; x++) {
      DateTime itemDate = DateTime.parse(meelList[x]['date']);
      if (itemDate.day == selectedDate.day &&
          itemDate.month == selectedDate.month) {
        b += int.parse(meelList[x]['protein'].toString());
      }
    }
    return b;
  }

  Future<int> getCarps() async {
    int b = 0;
    for (int x = 0; x < meelList.length; x++) {
      DateTime itemDate = DateTime.parse(meelList[x]['date']);
      if (itemDate.day == selectedDate.day &&
          itemDate.month == selectedDate.month) {
        b += int.parse(meelList[x]['carps'].toString());
      }
    }
    return b;
  }

  Future<int> getFat() async {
    int b = 0;
    for (int x = 0; x < meelList.length; x++) {
      DateTime itemDate = DateTime.parse(meelList[x]['date']);
      if (itemDate.day == selectedDate.day &&
          itemDate.month == selectedDate.month) {
        b += int.parse(meelList[x]['fat'].toString());
      }
    }
    return b;
  }

  getValues() async {
    calorie.value = await getCalorie();
    protein.value = await getProtien();
    carps.value = await getCarps();
    fat.value = await getFat();
  }

  var calorie = 0.obs;
  var protein = 0.obs;
  var carps = 0.obs;
  var fat = 0.obs;

  Future fetchData() async {
    List<Map> data = await mySql.readData('SELECT * FROM meel');
    meelList.assignAll(data.where((item) {
      DateTime date = DateTime.parse(item['date']);
      return date.day == selectedDate.day;
    }));
    getValues();
    isLoading.value = false;
  }

  late final List<DateTime> days;
  late final ScrollController scrollController;
  late DateTime selectedDate;
  bool isSelected = false;
  Future<void> deleteMeel(int id) async {
    mySql.deleteData('''
                        DELETE FROM meel WHERE id = $id
''');
    fetchData();
  }

  Future<void> deleteMealFromAddMealScreen(int id) async {
    mySql.deleteData('''
                        DELETE FROM option WHERE id = $id
''');
  }

  changeDate(DateTime day) {
    isSelected = selectedDate.year == day.year &&
        selectedDate.month == day.month &&
        selectedDate.day == day.day;
  }

  String dayOfWeek(DateTime date) {
    List<String> days = [
      'Sun'.tr,
      'Mon'.tr,
      'Tue'.tr,
      'Wed'.tr,
      'Thu'.tr,
      'Fri'.tr,
      'Sat'.tr
    ];
    return days[date.weekday % 7];
  }

  List<DateTime> initaiateDays(DateTime start, DateTime end) {
    final List<DateTime> days = [];
    bool conditions(int i) =>
        start.add(Duration(days: i)).isBefore(end) ||
        start.add(Duration(days: i)) == end;
    for (int i = 0; conditions(i); i++) {
      days.add(start.add(Duration(days: i)));
    }
    return days;
  }

  double initaiateOffset() {
    final DateTime today = DateTime.now();
    final index = days.indexWhere((day) =>
        day.year == today.year &&
        day.month == today.month &&
        day.day == today.day);
    if (index == -1) {
      return 0;
    }
    double dayWidth = 70;
    double spacing = 8;
    return index * (dayWidth * spacing);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();

    DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
    DateTime endDate = DateTime.now().add(const Duration(days: 0));
    days = initaiateDays(startDate, endDate);
    scrollController = ScrollController(initialScrollOffset: initaiateOffset());
    selectedDate = DateTime.now();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

class SettingsController extends GetxController {
  RxInt selectedAge = 200.obs;
  RxInt selectedHeight = 275.obs;
  RxInt selectedWeight = 310.obs;
  RxDouble bmi = 0.0.obs;
  RxDouble calorie = 2000.0.obs;
  void getPersonalInfo() {
    int age = GetStorage().read('age') ?? 200;
    int height = GetStorage().read('height') ?? 275;
    int weight = GetStorage().read('weight') ?? 310;
    double b = GetStorage().read('bmi') ?? 0;
    double c = GetStorage().read('calorie') ?? 2000;
    String sex = GetStorage().read('gender') ?? '';

    selectedAge.value = age;
    selectedHeight.value = height;
    selectedWeight.value = weight;
    gender.value = sex;
    bmi.value = b;
    calorie.value = c;
    getCalBmi();
  }

  void savePersonalInfo() {
    GetStorage().write('age', selectedAge.value);
    GetStorage().write('height', selectedHeight.value);
    GetStorage().write('weight', selectedWeight.value);
    GetStorage().write('gender', gender.value);
    GetStorage().write('bmi', bmi.value);
    GetStorage().write('calorie', calorie.value);
  }

  var gender = ''.obs;
  changeLang(BuildContext context) async {
    await Get.bottomSheet(
        isDismissible: true,
        enableDrag: true,
        Container(
          height: Get.height * 0.25,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey),
              ),
              Column(
                children: [
                  _changeLanguage(
                    context,
                    widget: Row(children: [
                      const Text(
                        '🇱🇾',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('Arabic'.tr, style: const TextStyle(fontSize: 16)),
                    ]),
                    value: 'ar',
                  ),
                  _changeLanguage(
                    context,
                    widget: Row(children: [
                      const Text(
                        '🇺🇸',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text('English'.tr, style: const TextStyle(fontSize: 16)),
                    ]),
                    value: 'en',
                  ),
                ],
              ),
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent),
              ),
            ],
          ),
        ));
  }

  RadioListTile<String> _changeLanguage(BuildContext context,
      {required String value, required Widget widget}) {
    return RadioListTile(
        title: widget,
        activeColor: Theme.of(context).primaryColor,
        value: value,
        groupValue: groupValue,
        onChanged: (val) {
          groupValue = val!;
          changeLocale(val);
          lang = val;
          Get.back();
        });
  }

  String? lang;
  Locale initLocale = GetStorage().read('ln') == null
      ? Get.deviceLocale!
      : GetStorage().read('ln') == 'ar'
          ? const Locale('ar')
          : const Locale('en');
  var selectedColor = Rx<Color>(Colors.green);
  bool? isDarkMode;
  void toggleTheme(bool value) {
    GetStorage().write('isDarkMode', value);
    isDarkMode = value;
    update();
  }

  String groupValue = '';
  int signIn = GetStorage().read('signIn') ?? 0;
  changeSignIn() {
    if (canCalculate()) {
      signIn = 1;
      GetStorage().write('signIn', signIn);
      savePersonalInfo();
      Get.off(() => HomeScreen());
    } else {
      Get.snackbar('error'.tr, 'error message'.tr);
    }
  }

  int seletedIndex = 0;
  onPageChanged(int index) {
    seletedIndex = index;
    update();
  }

  Color bmiColor() {
    if (bmi.value == 0) {
      return isDarkMode! ? Colors.white : Colors.black;
    } else if (bmi.value > 0 && bmi.value < 18.5) {
      return Colors.blue;
    } else if (bmi.value < 24.9 && bmi.value >= 18.5) {
      return Colors.green;
    } else if (bmi.value >= 24.9 && bmi.value <= 29.9) {
      return Colors.orange;
    } else if (bmi.value > 29.9 && bmi.value <= 34.9) {
      return Colors.red;
    }
    return const Color.fromARGB(255, 95, 1, 1);
  }

  changeLocale(String ln) {
    lang = ln;
    GetStorage().write('ln', ln);
    Locale locale = Locale(ln);

    Get.updateLocale(locale);
  }

  void saveColor(Color color) {
    GetStorage().write('selectedColor', color.value); // حفظ اللون
    selectedColor.value = color; // تحديث اللون
  }

  String? font;
  void changeFont(String newFont) {
    GetStorage().write('font', newFont);
    font = newFont;
    update();
  }

  void skipButton(PageController controller) {
    controller.animateToPage(2,
        duration: const Duration(milliseconds: 125), curve: Curves.linear);
  }

  String calculateBMI() {
    if (canCalculate()) {
      double x = selectedHeight / 100;
      bmi.value = (selectedWeight / (x * x));

      return x == 0 ? '0' : bmi.toStringAsFixed(1);
    }
    return '0';
  }

  var calorieValue = ''.obs;
  var bmiValue = ''.obs;
  void getCalBmi() async {
    bmiValue.value = calculateBMI();
    calorieValue.value = calculateCalori();
  }

  String calculateCalori() {
    if (canCalculate()) {
      if (gender.value == 'Male') {
        calorie.value = ((10 * selectedWeight.value) +
                (6.25 * selectedHeight.value) -
                (5 * selectedAge.value) +
                5) *
            1.2;

        return calorie.toStringAsFixed(0);
      }

      calorie.value = ((10 * selectedWeight.value) +
              (6.25 * selectedHeight.value) -
              (5 * selectedAge.value) -
              161) *
          1.2;

      return calorie.toStringAsFixed(0);
    }
    return '0';
  }

  bool canCalculate() {
    if (gender.value.isNotEmpty &&
        selectedAge.value != 200 &&
        selectedWeight.value != 310 &&
        selectedHeight.value != 275) {
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    getPersonalInfo();

    font = GetStorage().read('font') == null
        ? 'Almarai'
        : GetStorage().read('font') == 'Almarai'
            ? 'Almarai'
            : 'Roboto';
    final savedColorValue = GetStorage().read<int>('selectedColor');

    if (savedColorValue != null) {
      selectedColor.value = Color(savedColorValue);
    }
    isDarkMode = GetStorage().read('isDarkMode') == null
        ? Get.isPlatformDarkMode
            ? true
            : false
        : GetStorage().read('isDarkMode') == true
            ? true
            : false;
    lang = GetStorage().read('ln') != null
        ? (GetStorage().read('ln') == 'ar' ? 'ar' : 'en')
        : Get.deviceLocale!.languageCode == 'ar'
            ? 'ar'
            : 'en';
    groupValue = lang!;
    super.onInit();
  }
}
