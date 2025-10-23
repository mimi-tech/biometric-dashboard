import 'package:another_flushbar/flushbar.dart';
import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

enum ToastType { warning, success }

class AppToast {
  static void show({
    required BuildContext context,
    required String message,
    required ToastType toastType,
    String? title,
    Color titleColor = AppSemanticColors.fontIconInverse,
    Color? messageColor,
    Color? backgroundColor,
  }) {
    Flushbar<void>(
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyle.p4.copyWith(color: titleColor),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyle.p4.copyWith(
          color: messageColor ?? AppSemanticColors.fontIconInverse,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      maxWidth: MediaQuery.of(context).size.width * 0.9,
      borderRadius: BorderRadius.circular(AppRadius.l),
      flushbarPosition: FlushbarPosition.TOP,
      icon: toastType == ToastType.warning
          ? const Icon(Icons.warning)
          : const Icon(Icons.check),
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: backgroundColor ?? AppPrimitiveColors.bAlpha80,
      duration: const Duration(seconds: 4),
    ).show(context);
  }
}
