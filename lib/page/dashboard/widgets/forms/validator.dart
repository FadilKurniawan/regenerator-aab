import 'package:get/get.dart';

class Validator {
  Validator();

  String? notEmpty(String? value) {
    // String pattern = r'^\S+$';
    // RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty)
      return 'cannot be empty'.tr;
    else
      return null;
  }
}
