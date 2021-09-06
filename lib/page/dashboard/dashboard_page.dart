import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regenerator_aab/page/dashboard/widgets/build_forms.dart';
import 'package:regenerator_aab/page/dashboard/widgets/build_header.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BuildHeader(),
            BuildForms(),
          ],
        ),
      ),
    );
  }
}
