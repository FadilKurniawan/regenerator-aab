import 'package:flutter/material.dart';
import 'package:regenerator_aab/resources/resources.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    this.title,
    this.child,
    this.suffixChild,
    this.titlePadding = const EdgeInsets.only(bottom: 8),
    this.rowTitleSuffix,
    this.titleStyle,
  }) : super(key: key);

  final String? title;
  final Widget? child;
  final Widget? suffixChild;
  final EdgeInsets titlePadding;
  final MainAxisAlignment? rowTitleSuffix;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        title != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment:
                      rowTitleSuffix ?? MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title ?? '',
                        style: titleStyle ??
                            Theme.of(context).textTheme.bodyText2?.copyWith(
                                color: Resources.color.black,
                                fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 9),
                    suffixChild ?? Container(),
                  ],
                ),
              )
            : Container(),
        child ?? Container(),
      ],
    );
  }
}
