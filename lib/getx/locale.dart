import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'title': 'كالوري',
          'dev':
              "تم تطويره بواسطة نجيد عبدالله عيسى\n© 2025 جميع الحقوق محفوظة",
          'back': 'رجوع',
          //Add Meal Screen
          'no option':
              "لم تقم بإعداد أي وجبات بعد\n قم بإعداد وجبتك الأولى الآن (+)",
          'filter': 'الترتيب',
          'filter by': 'الترتيب حسب:',
          'Title': 'اسم الوجبة',
          'Calorie': 'السعرات الحرارية',
          'Default': 'الترتيب الافتراضي',
          'no data meal': "لا توجد وجبة بهذا الاسم",
          'deleting meel': 'هذا سوف يقوم بحذف الوجبة',
          'Added to Meal': 'إضافة الى الوجبات',
          'meel added': 'تمت إضافة الوجبة',
          'Edit Meal': 'تعديل الوجبة',
          'hint text field': 'ابحث عن وجبة..',
          //Edit Option Screen
          'edit': 'تعديل',
          'edit choice': 'تعديل الوجبة',
          //Add option screan
          'add': 'إضافة',
          'error save':
              'هناك بعض الحقول المفقودة، يُرجى التحقق وإكمال البيانات.',
          'unit': 'الوحدة',
          'Mille': 'مل',
          'Gram': 'جم',
          'Piece': 'قطعة',
          'meel name': 'اسم الوجبة',

          "Gallery": "المعرض",
          "Camera": "الكاميرا",

          //Item Screen
          'change save': 'تم حفظ التغيير ✅',
          'save': 'حفظ',
          'Gram Unit': 'وحدة الغرام',
          'itemProtien': 'البروتين',
          'itemCarps': 'الكاربس',
          'itemFat': 'الدهون',
          // الشاشة الرئيسية
          'go up': 'اذهب إلى الأعلى',
          'calorie done': 'لقد وصلت إلى\n الحد اليومي من السعرات الحرارية.',
          'no meel': "لم تقم بإضافة أي وجبات بعد\n اضف وجبتك الأولى الآن (+)",
          'kcal': 'سعرة حرارية',
          'g': 'ج', 'add choice': 'إعداد وجبة',
          'add meal': 'إضافة وجبة',
          'protien': 'البروتين المتبقي',
          'carps': 'الكاربس المتبقي',
          'fat': 'الدهون المتبقية',
          'meel': 'الوجبات',
          'Calories\nrestantes': 'المتبقي من\nالسعرات الحرارية',
          'Mon': 'ا',
          'Tue': 'ث',
          'Wed': 'أ',
          'Thu': 'خ',
          'Fri': 'ج',
          'Sat': 'س',
          'Sun': 'ح',

          // شاشة البداية
          'Welcome to Calorie': 'مرحبًا بك في كالوري',

          'Select Gender': 'اختر الجنس',
          'Male': 'ذكر',
          'Female': 'أنثى',
          'age': 'العمر',
          'height': 'الطول',
          'OK': 'تأكيد',
          'cm': 'سم',
          'kg': 'كجم',
          'weight': 'الوزن',
          'Caloric needs': "احتياجك من السعرات",
          // شاشة التعليمات
          'error': 'بيانات غير مكتملة',
          'error message':
              'يرجى إدخال جميع المعلومات الشخصية لحساب مؤشر كتلة الجسم والسعرات الحرارية.',

          'underweight': 'نقص الوزن (<18.5)',
          'normal': 'الوزن الطبيعي (18.5 - 24.9)',
          'overweight': 'زيادة الوزن (25 - 29.9)',
          'obese': 'السمنة (30 - 34.9)',
          'extreme_obese': 'السمنة المفرطة (>34.9)',
          'Your BMI is': 'مؤشر كتلة الجسم',

          'Easy To Use and calculate calories': 'احسب سعراتك الحرارية بسهولة',
          'Learn how to track your daily calorie intake easily':
              "التطبيق مصمم ليسهّل عليك تتبع وجباتك اليومية وحساب السعرات التي تتناولها، خطوة بخطوة، وبدون تعقيد",

          'Get Started': "ابدأ الآن",
          'skip': 'تخطي',
          'Start tracking your calories today':
              " صممنا لك تجربة استخدام بسيطة وسلسة تساعدك على تحقيق أهدافك الغذائية خطوة بخطوة",
          // شاشة الإعدادات
          'warnning': 'تحذير',
          'are you sure': "هل أنت متأكد أنك تريد حذف جميع البيانات؟",
          'cant go back': "لا يمكن التراجع عن هذا الإجراء!",
          'yes delete': "نعم احذف",
          'cancel': "إلغاء",
          '📏 Height | ⚖️ Weight | 🎂 Age': 'الطول,العمر & الوزن',

          'Info': 'معلوماتك الشخصية',
          'App Version: v1.0.0': 'إصدار التطبيق: v1.0.0',
          'setting title': 'الإعدادات',
          'theme': 'المظهر',
          'Dark Mode': 'الوضع الليلي',
          'Display Color': 'ألوان العرض',
          'Text': 'نمط النص',
          'Language': "اللغة",
          'Arabic': 'العربية',
          'English': 'الإنجليزية',
          'Font Style': 'نوع الخط',
          'System': 'النظام',
          'Notifications': 'الإشعارات',
          'Application': 'التطبيق',
          "Rate the app on the store": 'قيّم التطبيق على المتجر',
          'Share Application': "مشاركة التطبيق",
          'Delete Data': "حذف البيانات",
          "Select a Color": 'اختر لونًا',
          'Ok': 'موافق',
        },
        'en': {
          'title': 'Calorie',
          'dev':
              'Developed by Nojaid Abdullah Issa\n© 2025 All rights reserved',
          'back': 'Go back',
          //Add Meal Screen
          'no option':
              "You haven't made any meals yet\n set up your first meal now (+)",
          'filter': 'Sort',
          "filter by": "Sotrt by",
          "Title": "Meal Name",
          "Calorie": "Calories",
          "Default": "Default sort",
          'no data meal': "No meal found with this name",
          'deleting meel': 'This will delete the meal',
          "Add to Meals": "Add to Meals",
          'meel added': 'Meal Added',
          'Edit Meal': 'Edit Meal',
          'hint text field': 'Search for a meal...',
          //Edit Option Screen
          'edit': 'Edit',
          'edit choice': 'Edit Meal',

          // Add option screen
          'add': 'Add',
          'error save':
              'Some fields are missing, please check and complete the information.',
          'unit': 'Unit',
          'Mille': 'mL',
          'Gram': 'g',
          'Piece': 'pcs',
          'meel name': 'Meal Name',

          "Gallery": "Gallery",
          "Camera": "Camera",

          //Item Screen
          'save': 'Save',
          "change save": "Change saved ✅",
          'Gram Unit': 'Gram Unit',
          'itemProtien': 'Protein',
          'itemCarps': 'Carps',
          'itemFat': 'Fat',
          // HomeScreen
          'go up': 'Go to top',
          'calorie done': 'You\'ve reached \nyour daily calorie limit.',
          'no meel':
              "You haven't added any meals yet\n add your first meal now (+)",
          'meel': 'Meals',
          'g': 'g',
          'protien': 'Protien restantes',
          'carps': 'Carps restantes',
          'fat': 'Fat restantes',
          'Calories\nrestantes': 'Calories\nrestantes',
          'add meal': 'Add Meal',
          'add choice': "Set Up Meal",
          'Mon': 'M',
          'Tue': 'T',
          'Wed': 'W',
          'Thu': 'T',
          'Fri': 'F',
          'Sat': 'S',
          'Sun': 'S',
          // Splash Screen
          'Welcome to Calorie': 'Welcome to Calorie',
          // TutorialScreen
          'error': 'Incomplete Data',
          'error message':
              'Please enter all personal information to calculate BMI and calories.',

          'underweight': 'Underweight (<18.5)',
          'normal': 'Normal (18.5 - 24.9)',
          'overweight': 'Overweight (25 - 29.9)',
          'obese': 'Obese (30 - 34.9)',
          'extreme_obese': 'Extreme Obese (>34.9)',

          'Select Gender': 'Gender',
          'Male': 'Male',
          'Female': 'Female',
          'OK': 'Confirm',
          'cm': 'cm',
          'kg': 'kg',
          'age': 'Age',
          'Your BMI is': 'Your BMI is',
          'Caloric needs': 'Caloric needs',
          'height': 'Height',
          'weight': "Weight",
          'Get Started': "Get Started Now",
          'Easy To Use and calculate calories': 'Easily Track Your Calories',
          "Learn how to track your daily calorie intake easily":
              "The app is designed to make it easy for you to track your daily meals and calculate the calories you consume, step by step, without any complications",

          'skip': 'Skip',
          'Start tracking your calories today':
              "We designed a simple and smooth user experience to help you achieve your nutritional goals step by step",
          // SettingsScreen
          'warnning': 'Warning',
          'are you sure': 'Are you sure you want to delete all data?',
          'cant go back': 'This action cannot be undone!',
          'yes delete': 'Yes delete',
          'cancel': 'Cancel',
          '📏 Height | ⚖️ Weight | 🎂 Age': 'Height,Age & Weight',
          'Info': 'Your Personal Information',
          'App Version: v1.0.0': 'App Version: v1.0.0',
          'setting title': 'Settings',
          'theme': 'Theme',
          'Dark Mode': 'Dark Mode',
          'Display Color': 'Display Colors',
          'Text': 'Text Style',
          'Language': 'Language',
          'Arabic': 'Arabic',
          'English': 'English',
          'Font Style': 'Font Style',
          'System': 'System',
          'Notifications': 'Notifications',
          'Application': 'Application',
          "Rate the app on the store": "Rate the app on the Store",
          'Share Application': 'Share the App',
          'Delete Data': 'Delete All Data',
          "Select a Color": "Choose a Color",
          'Ok': 'OK',
        }
      };
}
