import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

class AppConfirmDialog extends StatelessWidget {
  const AppConfirmDialog({
    this.confirmButtonText,
    this.cancelButtonText,
    super.key,
    this.title,
    this.content,
    this.onTapConfirmButton,
    this.onTapCancelButton,
    this.cancelButtonColor = ButtonColor.lightGray,
    this.confirmButtonColor = ButtonColor.primary,
    this.hasDifferentContent,
    this.isOptionChecked = false,
    this.onTapCheckBox,
  });
  final String? title;
  final String? content;
  final String? confirmButtonText;
  final String? cancelButtonText;
  final VoidCallback? onTapConfirmButton;
  final VoidCallback? onTapCancelButton;
  final ButtonColor cancelButtonColor;
  final ButtonColor confirmButtonColor;
  final bool? hasDifferentContent;
  final bool? isOptionChecked;
  final VoidCallback? onTapCheckBox;

  /// Static method to show the dialog
  static Future<bool?> show(
    BuildContext context, {
    String? confirmButtonText,
    String? cancelButtonText,
    String? title,
    String? content,
    bool? hasDifferentContent = false,
    VoidCallback? onTapConfirmButton,
    VoidCallback? onTapCancelButton,
    bool isLoading = false,
    ButtonColor cancelButtonColor = ButtonColor.lightGray,
    ButtonColor confirmButtonColor = ButtonColor.primary,
    bool? isOptionChecked = false,
    VoidCallback? onTapCheckBox,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppConfirmDialog(
          title: title,
          content: content,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          onTapCancelButton: onTapCancelButton,
          onTapConfirmButton: onTapConfirmButton,
          cancelButtonColor: cancelButtonColor,
          confirmButtonColor: confirmButtonColor,
          hasDifferentContent: hasDifferentContent,
          isOptionChecked: isOptionChecked,
          onTapCheckBox: onTapCheckBox,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppPrimitiveColors.white,
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
                style: AppTextStyle.h5.semiBold.fontIconPrimary,
              ),
              const SizedBox(height: 8),
            ],
            // Display the content if provided
            if (content != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.xxl),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasDifferentContent ?? false) const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        content!,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.p4.fontIconSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 36),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelButtonText ?? '취소',
                    color: cancelButtonColor,
                    size: ButtonSize.l,
                    onPressed: onTapCancelButton ??
                        () {
                          Navigator.of(context).pop();
                        },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppButton(
                    label: confirmButtonText ?? '확인',
                    color: confirmButtonColor,
                    size: ButtonSize.l,
                    onPressed: onTapConfirmButton ??
                        () {
                          Navigator.of(context).pop();
                        },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
