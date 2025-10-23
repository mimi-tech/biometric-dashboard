import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

enum TextButtonType {
  underline,
  basic,
}

enum ButtonStatus { active, highlighted, disabled }

enum TextColor { primary, secondary, red, black, white, gray, custom }

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.color = TextColor.primary,
    this.customColor,
    this.padding,
    this.size = ButtonSize.m,
    this.status = ButtonStatus.active,
    this.iconLeftSwap,
    this.iconRightSwap,
    this.textButtonType = TextButtonType.basic,
  });

  final String text;
  final VoidCallback onPressed;
  final TextColor color;
  final Color? customColor;
  final ButtonSize size;
  final ButtonStatus status;
  final EdgeInsetsGeometry? padding;
  final IconData? iconLeftSwap;
  final IconData? iconRightSwap;
  final TextButtonType textButtonType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (padding == null || padding == EdgeInsets.zero)
          ? _getFontSize()
          : null,
      child: TextButton(
        onPressed: status == ButtonStatus.disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: padding ?? EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(decoration: TextDecoration.none),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconLeftSwap != null)
          Icon(
            iconLeftSwap,
            size: _getIconSize(),
            color: _getTextColor(),
          ),
        if (iconLeftSwap != null) const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            height: 1,
            fontSize: _getFontSize(),
            color: _getTextColor(),
            decorationColor: _getTextColor(),
            decoration: textButtonType == TextButtonType.basic
                ? TextDecoration.none
                : TextDecoration.underline,
          ),
        ),
        if (iconRightSwap != null) const SizedBox(width: 8),
        if (iconRightSwap != null)
          Icon(
            iconRightSwap,
            size: _getIconSize(),
            color: _getTextColor(),
          ),
      ],
    );
  }

  Color _getTextColor() {
    Color textColor;
    switch (color) {
      case TextColor.primary:
        textColor = AppSemanticColors.fontIconInteractivePrimary;
      case TextColor.secondary:
        textColor = AppSemanticColors.fontIconInteractiveSecondary;
      case TextColor.red:
        textColor = AppSemanticColors.feedbackDanger;
      case TextColor.black:
        textColor = Colors.black;
      case TextColor.white:
        textColor = AppSemanticColors.fontIconInverse;
      case TextColor.gray:
        textColor = AppSemanticColors.fontIconTertiary;
      case TextColor.custom:
        textColor = customColor ?? AppSemanticColors.fontIconInteractivePrimary;
    }
    if (status == ButtonStatus.disabled) {
      return AppSemanticColors.fontIconInteractiveQuaternary;
    }
    return textColor;
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.s:
        return 12;
      case ButtonSize.m:
        return 14;
      case ButtonSize.l:
        return 16;
      case ButtonSize.xl:
        return 18;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.s:
        return 16;
      case ButtonSize.m:
        return 18;
      case ButtonSize.l:
        return 20;
      case ButtonSize.xl:
        return 22;
    }
  }
}
