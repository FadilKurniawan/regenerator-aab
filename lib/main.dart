import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:regenerator_aab/routes/page_names.dart';
import 'package:regenerator_aab/routes/page_routes.dart';
import 'package:regenerator_aab/themes/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await globalLocalData();
  runApp(MyApp());
}

globalLocalData() async {
  await GetStorage.init();
  // await Get.putAsync<GetStorage>(() async {
  //   return GetStorage();
  // });
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
