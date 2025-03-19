import 'dart:io';

import 'package:docucare/styles/app_colors.dart';
import 'package:docucare/utils/core.dart';
import 'package:intl/intl.dart';

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

  /// Open Gmail app
  Future<void> openGmailApp() async {
    const mailtoUrl = 'mailto:';
    try {
      final Uri toLaunch = Uri.parse(mailtoUrl);
      await launchUrl(toLaunch);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Format date and time
  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  /// Convert byte to GB
  String bytesToGB(int bytes) {
    if (bytes <= 0) return '0 GB';
    final gb = bytes / (1024 * 1024 * 1024);
    return '${gb.toStringAsFixed(2)} GB';
  }
}
