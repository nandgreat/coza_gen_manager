import 'package:coza_gen_manager/res/color_palette.dart';
import 'package:coza_gen_manager/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'modules/home/home_bindings.dart';
import 'modules/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      fontFamily: 'Poppins',
      primaryColor: primaryColor,
      selectedRowColor: secondaryColor,
    );

    var defaultDurationTransition;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COZA Gen Manager',
      theme: themeData,
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
      initialBinding: HomeBinding(),
      getPages: AppPages.pages,
      home: const LoginScreen(),
    );
  }
}
