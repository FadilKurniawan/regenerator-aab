import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:regenerator_aab/models/list_profile.dart';
import 'package:regenerator_aab/models/profile_data.dart';
import 'package:regenerator_aab/resources/resources.dart';
import 'package:sizer/sizer.dart';

enum RefresherStatus { initial, loading, success, error, empty }

class DashboardController extends GetxController {
  var storage = GetStorage();
  final storeProfile = 'profile';
  RxList<String> profileList = ['default'].obs;
  RxString selectedProfile = 'default'.obs;
  // final PathProviderWindows provider = PathProviderWindows();

  String appCreateDir = '';
  String apksDir = '';
  String apkDir = '';
  RxString finalCMD = ''.obs;

  @override
  void onInit() {
    getDownloadDir();
    initStorage();
    loadStorage();
    checkExistDir(apksDir);
    super.onInit();
  }

  initStorage() async {
    if (!storage.hasData(storeProfile)) {
      await storage.write(
          storeProfile,
          // ignore: invalid_use_of_protected_member
          ProfielList(list: profileList.value).toJson());
    }
    if (!storage.hasData(selectedProfile.value)) {
      await storage.write(
          selectedProfile.value,
          // ignore: invalid_use_of_protected_member
          ProfileData().toJson());
    }
  }

  loadStorage() async {
    List<String> list = [];
    list.addAll(ProfielList.fromJson(storage.read(storeProfile)).list);
    profileList.value = list;
    update();
  }

  saveDataProfile() async {
    await storage.write(
        selectedProfile.value,
        // ignore: invalid_use_of_protected_member
        ProfileData(
          aabPath: aabPathController.text,
          bundlePath: toolsPathController.text,
          keyAlias: keysAliasController.text,
          keyPass: keysPasswordController.text,
          keyPath: keysPathController.text,
          name: apkNameController.text,
          outputName: apkNameController.text,
          pubspecPath: projPathController.text,
        ).toJson());

    Get.snackbar('Success', 'Data Saved',
        icon: Icon(
          Icons.check_rounded,
          color: Colors.white,
        ),
        margin: EdgeInsets.all(30),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.green,
        colorText: Colors.white);
    update();
  }

  getDownloadDir() async {
    status = RefresherStatus.loading;
    update();
    // try {
    //   appCreateDir = await provider.getApplicationDocumentsPath() ?? '';
    //   apksDirInit();
    // } catch (exception) {
    appCreateDir = 'd:\\regen';
    apksDirInit();
    // }
  }

  apksDirInit() {
    checkExistDir(appCreateDir);
    apksDir = appCreateDir + "\\apks\\";
    checkExistDir(apksDir);
    apkDir = appCreateDir + "\\apk\\";
    checkExistDir(apkDir);
    status = RefresherStatus.initial;
    update();
  }

  RefresherStatus status = RefresherStatus.initial;
  bool get isInitial => status == RefresherStatus.initial;
  bool get isLoading => status == RefresherStatus.loading;
  bool get isShimmering => isLoading && isEmptyData;
  bool get isEmptyData => status == RefresherStatus.empty;
  bool get isSuccess => status == RefresherStatus.success;
  bool get isError => status == RefresherStatus.error;

  final formProfileKey = GlobalKey<FormBuilderState>();
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController newProfileController = TextEditingController();
  TextEditingController projPathController = TextEditingController();
  TextEditingController toolsPathController = TextEditingController();
  TextEditingController aabPathController = TextEditingController();
  TextEditingController apkNameController = TextEditingController();
  TextEditingController keysPathController = TextEditingController();
  TextEditingController keysAliasController = TextEditingController();
  TextEditingController keysPasswordController = TextEditingController();

  @override
  void onClose() {
    newProfileController.dispose();
    projPathController.dispose();
    toolsPathController.dispose();
    aabPathController.dispose();
    apkNameController.dispose();
    keysPathController.dispose();
    keysAliasController.dispose();
    keysPasswordController.dispose();
    super.onClose();
  }

  var counter = 0.obs;
  set obj(value) => this.counter.value = value;
  get obj => this.counter.value;

  void incrementCounter() {
    toolsPathController.text = (counter.value++).toString();
    update();
  }

  Future<String> run(
    String command, {
    bool cmd = false,
    List<String> arguments = const [],
  }) async {
    String result = '';
    status = RefresherStatus.loading;
    update();
    await Future.delayed(Duration(seconds: 1));
    try {
      await Process.start(command, arguments, runInShell: cmd).then((process) {
        // process.stdout.transform(utf8.decoder).listen((data) {
        //   result = data;
        //   debugPrint("GET => " + data);
        // });
        process.stderr.transform(utf8.decoder).listen((event) {
          showError(event);
          status = RefresherStatus.error;
          update();
        });
        process.exitCode.then((exitCode) {
          debugPrint('exit code: $exitCode');
          if (exitCode == 0) {
            status = RefresherStatus.success;
            update();
          }
        });
      });
    } on ProcessException catch (e) {
      debugPrint("${e.toString()}");
      showError(e.message.toString());
      status = RefresherStatus.error;
      update();
    }
    return result;
  }

  showError(String? err) {
    Get.defaultDialog(
      title: 'Oops..',
      titlePadding: EdgeInsets.only(top: 24),
      content: Padding(
        padding: const EdgeInsets.all(12),
        child: SelectableText("$err"),
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

  Future<void> execute() async {
    // dir path
    debugPrint(appCreateDir);
    debugPrint("APKS DIR=>" + apksDir);

    await run('java', arguments: [
      '-jar',
      '${toolsPathController.text.replaceAll("\\", '\\\\')}',
      'build-apks',
      '--overwrite',
      '--mode=universal',
      '--bundle=${aabPathController.text.replaceAll("\\", '\\\\')}',
      '--output=$apksDir\\${apkNameController.text}.apks',
      '--ks=${keysPathController.text.replaceAll("\\", '\\\\')}',
      '--ks-pass=pass:${keysPasswordController.text}',
      '--ks-key-alias=${keysAliasController.text.replaceAll("\\", '\\\\')}',
      '--key-pass=pass:${keysPasswordController.text}',
    ]);

    await run('start',
        arguments: [
          'cmd',
        ],
        cmd: true);
    finalCMD.value = ('unzip -p $apksDir\\' +
            apkNameController.text +
            '.apks universal.apk \> $apkDir\\' +
            apkNameController.text +
            '.apk')
        .replaceAll('\\\\', '\\');
    update();
  }

  Future<void> checkExistDir(String path) async {
    bool exists = await Directory(path).exists();
    if (!exists) {
      Directory(path).create();
    }
  }

  Future<void> fillOther(String? path) async {
    if (path != null) {
      debugPrint(path);
      path = path.replaceAll('pubspec.yaml', '');
      var dirAab =
          path + 'build\\app\\outputs\\bundle\\release\\app-release.aab';
      debugPrint('aab dir:' + dirAab);
      if (await File(dirAab).exists()) {
        aabPathController.text = dirAab;
      } else {
        debugPrint('AAB NOT Exist');
      }
    }
    update();
  }

  Future<void> addNewProfile() async {
    await storage.write(newProfileController.text, ProfileData().toJson());
    List<String> list = [];
    // ignore: invalid_use_of_protected_member
    list.addAll(profileList.value);
    list.add(newProfileController.text);
    profileList.value = list;
    await storage.write(
        storeProfile, ProfielList(list: profileList.value).toJson());
    newProfileController.text = "";
    loadStorage();
  }

  void setSelectedProfile(String s) {
    selectedProfile.value = s;
    if (storage.hasData(selectedProfile.value)) {
      var strg = ProfileData.fromJson(storage.read(selectedProfile.value));
      projPathController.text = strg.pubspecPath ?? '';
      toolsPathController.text = strg.bundlePath ?? '';
      aabPathController.text = strg.aabPath ?? '';
      apkNameController.text = strg.outputName ?? '';
      keysPathController.text = strg.keyPath ?? '';
      keysAliasController.text = strg.keyAlias ?? '';
      keysPasswordController.text = strg.keyPass ?? '';
    }
    update();
  }
}
