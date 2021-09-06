import 'package:get/get.dart';
import 'package:regenerator_aab/page/dashboard/dashboard_binding.dart';
import 'package:regenerator_aab/page/dashboard/dashboard_page.dart';

import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
        name: PageName.DASHBOARD,
        page: () => DashboardPage(),
        binding: DashboardBinding()),
  ];
}
