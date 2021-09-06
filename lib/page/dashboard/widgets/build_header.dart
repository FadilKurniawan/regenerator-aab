import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:regenerator_aab/resources/resources.dart';
import 'package:sizer/sizer.dart';

class BuildHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Resources.color.colorPrimary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20.0))),
            child: Row(
              children: [
                Image(
                  image: Resources.images.imageLogo,
                  fit: BoxFit.fitWidth,
                  height: 20.sp,
                ),
                SizedBox(width: 5.sp),
                Padding(
                  padding: EdgeInsets.only(top: 8.sp),
                  child: Text(
                    'AAB Regenerator',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
