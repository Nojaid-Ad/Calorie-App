import 'package:animate_do/animate_do.dart';
import 'package:calorie/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

FadeIn tutrailPage(BuildContext context,
    {required String lottie, required String text, required String text2}) {
  return FadeIn(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
          radius: 120,
          backgroundColor: Get.theme.primaryColor.withOpacity(0.15),
          child: Lottie.asset(
            'assets/lottie/$lottie.json',
            width: 300,
            height: 300,
          ),
        ),
        h(64),
        FadeInDown(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 500),
          curve: Curves.linearToEaseOut,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        h(4),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut,
          child: Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Get.theme.hintColor),
          ),
        ),
        SizedBox(
          height: height * 0.15,
        ),
      ],
    ),
  );
}
