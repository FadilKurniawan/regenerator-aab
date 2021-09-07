import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:regenerator_aab/page/dashboard/widgets/primary_button.dart';
import 'package:regenerator_aab/resources/resources.dart';
import 'package:sizer/sizer.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon(
      {required this.name,
      required this.controller,
      this.iconPrefix,
      this.iconSuffix,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.enabled = true,
      this.minLines = 1,
      this.maxLines = 1,
      this.typeFile = false,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final String name;
  final IconData? iconPrefix;
  final IconData? iconSuffix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool typeFile;
  final int minLines;
  final int maxLines;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Container(
            width: typeFile ? 38.w : 50.w,
            child: FormBuilderTextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: enabled ? Colors.white : Colors.grey.shade200,
                prefixIcon: iconPrefix != null ? Icon(iconPrefix) : null,
                hintText: labelText,
                suffixIcon: iconSuffix != null ? Icon(iconSuffix) : null,
              ),
              enabled: enabled,
              controller: controller,
              onSaved: onSaved,
              onChanged: onChanged,
              keyboardType: keyboardType,
              obscureText: obscureText,
              maxLines: maxLines,
              minLines: minLines,
              validator: validator,
              name: name,
            ),
          ),
          typeFile
              ? Container(
                  width: 20.sp,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: PrimaryButton(
                    // height: 40.h,
                    width: 10.w,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      colors: <Color>[Colors.grey, Resources.color.grey],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Wrap(
                        children: [
                          Icon(
                            Icons.folder_open_sharp,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    onPressed: onFilePickAction,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  onFilePickAction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = File(result.files.single.path);
      controller.text = result.files.single.path;
      // ignore: unnecessary_statements
      onChanged != null ? onChanged!(controller.text) : () {};
    } else {
      // User canceled the picker
    }
  }
}
