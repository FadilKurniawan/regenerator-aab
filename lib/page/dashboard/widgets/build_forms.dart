import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:regenerator_aab/page/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:regenerator_aab/page/dashboard/widgets/forms/form_input_field_with_icon.dart';
import 'package:regenerator_aab/page/dashboard/widgets/forms/validator.dart';
import 'package:regenerator_aab/page/dashboard/widgets/input_label.dart';
import 'package:regenerator_aab/page/dashboard/widgets/primary_button.dart';
import 'package:regenerator_aab/resources/resources.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildForms extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      initState: (_) {},
      builder: (_) {
        return controller.isLoading
            ? Container(
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(
                        color: Resources.color.colorPrimary,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.all(14.sp),
                child: Column(
                  children: [
                    profileWidget(),
                    FormVerticalSpace(
                      height: 30,
                    ),
                    FormBuilder(
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
                                    title: 'Project Pubspec.yaml',
                                    child: FormInputFieldWithIcon(
                                      name: 'ppdir',
                                      enabled: false,
                                      controller: controller.projPathController,
                                      iconPrefix: Icons.drive_file_move,
                                      labelText: '../..',
                                      validator: null, // Validator().notEmpty,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        controller.fillOther(value);
                                      },
                                      onSaved: (value) => controller
                                          .projPathController.text = value!,
                                      typeFile: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50.w,
                                  margin: EdgeInsets.only(top: 20.sp),
                                  child: InputLabel(
                                    titleStyle: TextStyle(fontSize: 12),
                                    title: 'Bundletool path',
                                    child: FormInputFieldWithIcon(
                                      name: 'bundletool',
                                      enabled: !controller.isLoading,
                                      controller:
                                          controller.toolsPathController,
                                      iconPrefix: Icons.drive_file_move,
                                      labelText: '../..',
                                      validator: Validator().notEmpty,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      onChanged: (value) => null,
                                      onSaved: (value) => controller
                                          .toolsPathController.text = value!,
                                      typeFile: true,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50.w,
                                  margin: EdgeInsets.only(top: 20.sp),
                                  child: InputLabel(
                                    titleStyle: TextStyle(fontSize: 12),
                                    title: 'AAB path',
                                    child: FormInputFieldWithIcon(
                                      name: 'bundletool',
                                      enabled: !controller.isLoading,
                                      controller: controller.aabPathController,
                                      iconPrefix: Icons.drive_file_move,
                                      labelText: '../..',
                                      validator: Validator().notEmpty,
                                      keyboardType: TextInputType.emailAddress,
                                      maxLines: 1,
                                      onChanged: (value) => null,
                                      onSaved: (value) => controller
                                          .aabPathController.text = value!,
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
                                      iconPrefix:
                                          Icons.drive_file_rename_outline,
                                      labelText: 'input apk name'.tr,
                                      validator: Validator().notEmpty,
                                      onChanged: (value) => null,
                                      onSaved: (value) => controller
                                          .apkNameController.text = value!,
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
                                      onSaved: (value) => controller
                                          .keysPathController.text = value!,
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
                                      controller:
                                          controller.keysAliasController,
                                      iconPrefix: Icons.spellcheck_rounded,
                                      labelText: 'input the key alias',
                                      validator: Validator().notEmpty,
                                      onChanged: (value) => null,
                                      onSaved: (value) => controller
                                          .keysAliasController.text = value!,
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
                                      controller:
                                          controller.keysPasswordController,
                                      iconPrefix: Icons.lock,
                                      labelText: 'input the key password',
                                      validator: Validator().notEmpty,
                                      onChanged: (value) => null,
                                      onSaved: (value) => controller
                                          .keysPasswordController.text = value!,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FormVerticalSpace(height: 5.w),
                          controller.finalCMD.value.isNotEmpty
                              ? Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Container(
                                      width: 50.w,
                                      child: InputLabel(
                                        title:
                                            'Copy Paste and execute this on the Open Terminal:',
                                        titleStyle: TextStyle(fontSize: 12),
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  style: BorderStyle.solid,
                                                  color: Colors.grey.shade300),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SelectableText(
                                              controller.finalCMD.value,
                                              style: TextStyle(fontSize: 6.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 24.0),
                                      child: IconButton(
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: controller
                                                      .finalCMD.value))
                                              .then((value) {
                                            Get.snackbar('Copied',
                                                'Data Copied on clipboard',
                                                icon: Icon(
                                                  Icons.check_rounded,
                                                  color: Colors.white,
                                                ),
                                                margin: EdgeInsets.all(30),
                                                duration: Duration(seconds: 3),
                                                backgroundColor: Colors.grey,
                                                colorText: Colors.white);
                                          });
                                        },
                                        icon: Icon(Icons.copy_all),
                                        tooltip: 'Copy',
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          FormVerticalSpace(height: 5.w),
                          controller.isLoading
                              ? Container()
                              : Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    PrimaryButton(
                                        title: 'Generate',
                                        width: 70.w,
                                        onPressed: () async {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            controller.execute();
                                          } else {
                                            Get.defaultDialog(
                                              title: 'Sorry',
                                              titlePadding:
                                                  EdgeInsets.only(top: 24),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                child: Text(
                                                    "You have to fill the missing requirement"),
                                              ),
                                              backgroundColor: Colors.white,
                                              middleTextStyle: TextStyle(
                                                  color: Colors.black),
                                            );
                                          }
                                        }),
                                    FormHorizontalSpace(width: 48),
                                    controller.isSuccess
                                        ? PrimaryButton(
                                            title: 'Reveal Result',
                                            width: 70.w,
                                            reverse: true,
                                            shadow: BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: Offset(0.0, 1.5),
                                              blurRadius: 6,
                                            ),
                                            onPressed: () async {
                                              if (await canLaunch(
                                                  controller.apksDir)) {
                                                await launch(
                                                    controller.apksDir);
                                              } else {
                                                throw 'Could not launch ${controller.apksDir}';
                                              }
                                            })
                                        : Container(),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Center(
        child: Wrap(
          runSpacing: 20,
          children: [
            listProfile(),
            FormHorizontalSpace(width: 20),
            FormBuilder(
              key: controller.formProfileKey,
              child: Wrap(
                children: [
                  Container(
                    height: 40,
                    width: 40.w,
                    child: FormInputFieldWithIcon(
                      controller: controller.newProfileController,
                      iconPrefix: Icons.account_circle_rounded,
                      maxLines: 1,
                      labelText: 'new Profile',
                      name: 'new_profile',
                      onChanged: (String? val) {},
                      onSaved: (String? val) {},
                      validator: Validator().notEmpty,
                    ),
                  ),
                  FormHorizontalSpace(width: 20),
                  PrimaryButton(
                    height: 40,
                    width: 5.w,
                    child: Icon(
                      Icons.add,
                      color: Resources.color.colorPrimary,
                    ),
                    shadow: BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0.0, 1.5),
                      blurRadius: 4,
                    ),
                    reverse: true,
                    onPressed: () async {
                      if (controller.formProfileKey.currentState!
                          .saveAndValidate()) {
                        controller.addNewProfile();
                      } else {}
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listProfile() {
    return Wrap(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          child: Container(
            width: 20.w,
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: controller.selectedProfile.value,
              icon: Icon(Icons.arrow_drop_down_rounded),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              style: TextStyle(color: Resources.color.colorPrimary),
              underline: Container(
                height: 0,
              ),
              onChanged: (String? newValue) {
                controller.setSelectedProfile(newValue!);
              },
              items: controller.profileList
                  .map<DropdownMenuItem<String>>((String? value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value ?? ''),
                );
              }).toList(),
            ),
          ),
        ),
        FormHorizontalSpace(width: 20),
        PrimaryButton(
          child: Icon(
            Icons.save_sharp,
            color: Resources.color.colorPrimary,
          ),
          shadow: BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0.0, 1.5),
            blurRadius: 4,
          ),
          width: 6.w,
          reverse: true,
          onPressed: () async {
            controller.saveDataProfile();
          },
        )
      ],
    );
  }
}

class FormVerticalSpace extends SizedBox {
  FormVerticalSpace({double height = 24.0}) : super(height: height);
}

class FormHorizontalSpace extends SizedBox {
  FormHorizontalSpace({double width = 24.0}) : super(width: width);
}
