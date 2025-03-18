import 'dart:io';

import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';

class Utils {
  /// Show toast messages
  void showToast(String message, bool isError, bool isIOS) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: isIOS ? ToastGravity.TOP : ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: isError ? AppColors.warningColor : AppColors.greyColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0,
    );
  }

  /// Check the device
  bool checkPlatformIsIOS() {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  /// Validate Email address
  bool isEmailValid(String email) {
    final RegExp emailRegex = RegExp(r'^[\w.-]+@[\w-]+\.[\w.-]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
