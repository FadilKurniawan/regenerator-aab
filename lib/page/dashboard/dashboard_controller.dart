import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:regenerator_aab/resources/resources.dart';
import 'package:sizer/sizer.dart';

enum RefresherStatus { initial, loading, success, error, empty }

class DashboardController extends GetxController {
  RefresherStatus status = RefresherStatus.initial;
  bool get isInitial => status == RefresherStatus.initial;
  bool get isLoading => status == RefresherStatus.loading;
  bool get isShimmering => isLoading && isEmptyData;
  bool get isEmptyData => status == RefresherStatus.empty;
  bool get isSuccess => status == RefresherStatus.success;
  bool get isError => status == RefresherStatus.error;

  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController toolsPathController = TextEditingController();
  TextEditingController apkNameController = TextEditingController();
  TextEditingController keysPathController = TextEditingController();
  TextEditingController keysAliasController = TextEditingController();
  TextEditingController keysPasswordController = TextEditingController();

  var counter = 0.obs;
  set obj(value) => this.counter.value = value;
  get obj => this.counter.value;

  void incrementCounter() {
    toolsPathController.text = (counter.value++).toString();

    update();
  }

  Future<void> run() async {
    status = RefresherStatus.loading;
    update();
    try {
      var process = await Process.start(
              'alias bundletool=', ['java -jar d:/aab/bundletool.jar'],
              runInShell: true)
          .then((process) {
        process.stdout.transform(utf8.decoder).listen((data) {
          print(data);
        });
        process.stderr.transform(utf8.decoder).listen((event) {
          showError(event);
          status = RefresherStatus.error;
          update();
        });
        process.exitCode.then((exitCode) {
          print('exit code: $exitCode');
          if (exitCode != 0) {}
        });
      });
      status = RefresherStatus.success;
      update();
    } on ProcessException catch (e) {
      print("${e.toString()}");
      showError(e.message.toString());
      status = RefresherStatus.error;
      update();
    }
  }

  showError(String? err) {
    Get.defaultDialog(
      title: 'Oops..',
      titlePadding: EdgeInsets.only(top: 24),
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: Text("$err"),
      ),
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'OK',
            style: TextStyle(fontSize: 5.sp),
          )),
      confirmTextColor: Resources.color.colorPrimary,
      backgroundColor: Colors.white,
      middleTextStyle: TextStyle(color: Colors.black),
    );
  }
}
