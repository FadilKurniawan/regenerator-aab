import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regenerator_aab/routes/page_names.dart';
import 'package:regenerator_aab/routes/page_routes.dart';
import 'package:regenerator_aab/themes/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'REGEN AAB',
        initialRoute: PageName.DASHBOARD,
        getPages: PageRoutes.pages,
        theme: AppTheme.buildThemeData(false),
      );
    });
  }
}
