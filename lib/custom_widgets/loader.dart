import 'dart:io';

import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';
import 'package:flutter/cupertino.dart';

class Loader extends StatelessWidget {
  final double? strokeWidth;
  final Color? color;
  const Loader({super.key, this.strokeWidth, this.color});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator(
            color: color ?? AppColors.primaryColor,
          )
        : CircularProgressIndicator(
            strokeWidth: strokeWidth ?? 2,
            color: color ?? AppColors.primaryColor,
          );
  }
}
