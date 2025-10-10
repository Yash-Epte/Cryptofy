import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void successToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (
        context,
        animation,
        alignment,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: Icon(IconlyBold.tickSquare),
      boxShadow: highModeShadow,
      dragToClose: true,
      showProgressBar: false
    );
  }

  static void failureToast(
      BuildContext context, String title, String description) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.bottomRight,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (
        context,
        animation,
        alignment,
        child,
      ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      icon: Icon(IconlyBold.closeSquare),
      boxShadow: highModeShadow,
      dragToClose: true,
      primaryColor: Colors.redAccent
    );
  }
}
