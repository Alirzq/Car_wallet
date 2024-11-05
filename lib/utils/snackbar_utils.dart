import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showSnackbar({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: backgroundColor,
      colorText: textColor,
      duration: duration,
    );
  }

  static void showErrorSnackbar({
    String title = 'Error',
    required String message,
  }) {
    showSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showSuccessSnackbar({
    String title = 'Sukses',
    required String message,
  }) {
    showSnackbar(
      title: title,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
} 