import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:regenerator_aab/page/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:regenerator_aab/page/dashboard/widgets/forms/form_input_field_with_icon.dart';
import 'package:regenerator_aab/page/dashboard/widgets/forms/validator.dart';
import 'package:regenerator_aab/page/dashboard/widgets/input_label.dart';
import 'package:regenerator_aab/page/dashboard/widgets/primary_button.dart';
import 'package:sizer/sizer.dart';

class BuildForms extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return Container(
          margin: EdgeInsets.all(14.sp),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10.sp,
                    children: [
                      Container(
                        width: 50.w,
                        margin: EdgeInsets.only(top: 20.sp),
                        child: InputLabel(
                          titleStyle: TextStyle(fontSize: 12),
                          title: 'Bundletool path',
                          child: FormInputFieldWithIcon(
                            name: 'bundletool',
                            enabled: !controller.isLoading,
                            controller: controller.toolsPathController,
                            iconPrefix: Icons.drive_file_move,
                            labelText: '../..',
                            validator: Validator().notEmpty,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                controller.toolsPathController.text = value!,
                            typeFile: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        margin: EdgeInsets.only(top: 20.sp),
                        child: InputLabel(
                          titleStyle: TextStyle(fontSize: 12),
                          title: 'Output APK Name',
                          child: FormInputFieldWithIcon(
                            name: 'apk',
                            enabled: !controller.isLoading,
                            controller: controller.apkNameController,
                            iconPrefix: Icons.drive_file_rename_outline,
                            labelText: 'input apk name'.tr,
                            validator: Validator().notEmpty,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                controller.apkNameController.text = value!,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        margin: EdgeInsets.only(top: 20.sp),
                        child: InputLabel(
                          titleStyle: TextStyle(fontSize: 12),
                          title: 'Keystore path',
                          child: FormInputFieldWithIcon(
                            name: 'keystore',
                            enabled: !controller.isLoading,
                            controller: controller.keysPathController,
                            iconPrefix: Icons.drive_file_move,
                            labelText: '../..',
                            validator: Validator().notEmpty,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                controller.keysPathController.text = value!,
                            typeFile: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        margin: EdgeInsets.only(top: 20.sp),
                        child: InputLabel(
                          titleStyle: TextStyle(fontSize: 12),
                          title: 'Keystore Alias',
                          child: FormInputFieldWithIcon(
                            name: 'alias',
                            enabled: !controller.isLoading,
                            controller: controller.keysAliasController,
                            iconPrefix: Icons.spellcheck_rounded,
                            labelText: 'input the key alias',
                            validator: Validator().notEmpty,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                controller.keysAliasController.text = value!,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Container(
                        width: 50.w,
                        margin: EdgeInsets.only(top: 20.sp),
                        child: InputLabel(
                          titleStyle: TextStyle(fontSize: 12),
                          title: 'Keystore Password',
                          child: FormInputFieldWithIcon(
                            name: 'password',
                            enabled: !controller.isLoading,
                            controller: controller.keysPasswordController,
                            iconPrefix: Icons.lock,
                            labelText: 'input the key password',
                            validator: Validator().notEmpty,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                controller.keysPasswordController.text = value!,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FormVerticalSpace(height: 48),
                controller.isLoading
                    ? CircularProgressIndicator()
                    : Container(),
                controller.isLoading
                    ? Container()
                    : PrimaryButton(
                        title: 'Generate',
                        width: 70.w,
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            controller.run();
                          } else {
                            Get.defaultDialog(
                              title: 'Sorry',
                              titlePadding: EdgeInsets.only(top: 24),
                              content: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                    "You have to fill the missing requirement"),
                              ),
                              backgroundColor: Colors.white,
                              middleTextStyle: TextStyle(color: Colors.black),
                            );
                          }
                        }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FormVerticalSpace extends SizedBox {
  FormVerticalSpace({double height = 24.0}) : super(height: height);
}

class FormHorizontalSpace extends SizedBox {
  FormHorizontalSpace({double width = 24.0}) : super(width: width);
}
