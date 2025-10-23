import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    required this.buttonText,
    super.key,
    this.title,
    this.content,
    this.onTap,
    this.buttonColor = ButtonColor.primary,
  });
  final String buttonText;
  final String? title;
  final String? content;
  final VoidCallback? onTap;
  final ButtonColor buttonColor;

  static void show(
    BuildContext context, {
    required String buttonText,
    String? title,
    String? content,
    VoidCallback? onTap,
    bool? barrierDismissible,
    ButtonColor buttonColor = ButtonColor.primary,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: title,
          content: content,
          buttonText: buttonText,
          onTap: onTap,
          buttonColor: buttonColor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppSemanticColors.bgPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyle.h5.fontIconPrimary,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
            if (content != null) ...[
              Text(
                content!,
                textAlign: TextAlign.center,
                style: AppTextStyle.p4.fontIconSecondary,
              ),
            ],
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                label: buttonText,
                color: buttonColor,
                onPressed: onTap ??
                    () {
                      Navigator.of(context).pop();
                    },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
