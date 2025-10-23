import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

enum IconButtonShape { circle, rectangle }

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.onPressed,
    this.showSplash = true,
    this.icon,
    this.iconWidget,
    super.key,
    this.color = ButtonColor.primary,
    this.customColor,
    this.customForegroundColor,
    this.customIconColor,
    this.size = ButtonSize.m,
    this.radiusFull = false,
    this.isFilled = true,
    this.status = ButtonStatus.active,
    this.iconButtonShape = IconButtonShape.circle,
  });

  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onPressed;
  final ButtonColor color;
  final Color? customColor;
  final Color? customForegroundColor;
  final Color? customIconColor;
  final ButtonSize size;
  final bool radiusFull;
  final bool isFilled;
  final ButtonStatus status;
  final IconButtonShape iconButtonShape;
  final bool showSplash;

  @override
  Widget build(BuildContext context) {
    if (isFilled) {
      return SizedBox(
        height: _getSize(),
        width: _getSize(),
        child: ElevatedButton(
          onPressed: status == ButtonStatus.disabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: _getBackgroundColor(),
            foregroundColor: _getForegroundColor(),
            disabledBackgroundColor: AppSemanticColors.bgInteractiveQuaternary,
            disabledForegroundColor: AppSemanticColors.bgInteractiveQuaternary,
            shape: _getButtonShape(iconButtonShape, radiusFull),
            padding: _getPadding(),
            shadowColor: !showSplash ? Colors.transparent : null,
            overlayColor: !showSplash ? Colors.transparent : null,
          ),
          child: _buildButtonContent(),
        ),
      );
    } else {
      return SizedBox(
        height: _getSize(),
        width: _getSize(),
        child: OutlinedButton(
          onPressed: status == ButtonStatus.disabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            elevation: 0,
            foregroundColor: _getBackgroundColor(),
            backgroundColor: Colors.transparent,
            side: BorderSide(color: _getBorderSideColor()),
            shape: _getButtonShape(iconButtonShape, radiusFull),
            padding: _getPadding(),
          ),
          child: _buildButtonContent(),
        ),
      );
    }
  }

  double _getSize() {
    if (size == ButtonSize.s) {
      return 30;
    } else if (size == ButtonSize.m) {
      return 40;
    } else if (size == ButtonSize.l) {
      return 48;
    } else {
      return 56;
    }
  }

  Widget? _buildButtonContent() {
    if (iconWidget == null) {
      return Icon(
        icon,
        size: _getIconSize(),
        color: _getIconColor(),
      );
    } else {
      return iconWidget;
    }
  }

  Color _getBorderSideColor() {
    Color boarderColor;
    switch (color) {
      case ButtonColor.primary:
        boarderColor = AppSemanticColors.bgInteractivePrimary;
      case ButtonColor.secondary:
        boarderColor = AppSemanticColors.bgInteractiveSecondary;
      case ButtonColor.black:
        boarderColor = AppSemanticColors.bgInverse;
      case ButtonColor.lightGray:
        boarderColor = AppSemanticColors.bgInteractiveQuaternary;
      case ButtonColor.white:
        boarderColor = AppSemanticColors.bgPrimary;
      case ButtonColor.custom:
        boarderColor = customIconColor ?? Colors.white;
    }
    if (status == ButtonStatus.highlighted) {
      return isFilled
          ? boarderColor.withValues(alpha: 0.8)
          : AppSemanticColors.bgInteractivePrimary;
    }
    return boarderColor;
  }

  Color _getIconColor() {
    Color iconColor;
    switch (color) {
      case ButtonColor.primary:
        iconColor = isFilled
            ? AppSemanticColors.bgPrimary
            : AppSemanticColors.bgInteractivePrimary;

      case ButtonColor.secondary:
        iconColor = isFilled
            ? AppSemanticColors.bgPrimary
            : AppSemanticColors.bgInteractiveSecondary;

      case ButtonColor.black:
        iconColor = isFilled
            ? AppSemanticColors.bgPrimary
            : AppSemanticColors.bgInverse;

      case ButtonColor.lightGray:
        iconColor = isFilled
            ? AppSemanticColors.fontIconPrimary
            : AppSemanticColors.fontIconPrimary;

      case ButtonColor.white:
        iconColor = isFilled
            ? AppSemanticColors.fontIconPrimary
            : AppSemanticColors.bgPrimary;

      case ButtonColor.custom:
        iconColor = customIconColor ?? Colors.black;
    }
    if (status == ButtonStatus.highlighted) {
      return isFilled
          ? iconColor.withValues(alpha: 0.8)
          : AppSemanticColors.bgPrimary;
    }
    if (status == ButtonStatus.disabled) {
      return isFilled
          ? AppSemanticColors.fontIconInverse
          : AppSemanticColors.fontIconInteractiveQuaternary;
    }

    return iconColor;
  }

  Color _getBackgroundColor() {
    Color baseColor;
    switch (color) {
      case ButtonColor.primary:
        baseColor = AppSemanticColors.bgInteractivePrimary;

      case ButtonColor.secondary:
        baseColor = AppSemanticColors.bgInteractiveSecondary;

      case ButtonColor.black:
        baseColor = Colors.black;

      case ButtonColor.lightGray:
        baseColor = AppSemanticColors.bgInteractiveQuaternary;

      case ButtonColor.white:
        baseColor = Colors.transparent;

      case ButtonColor.custom:
        baseColor = customIconColor ?? Colors.white;
    }

    if (status == ButtonStatus.highlighted) {
      return isFilled
          ? baseColor.withValues(alpha: 0.8)
          : AppSemanticColors.bgPrimary;
    }
    return isFilled ? baseColor : AppSemanticColors.bgPrimary;
  }

  Color _getForegroundColor() {
    Color textColor;
    switch (color) {
      case ButtonColor.primary:
      case ButtonColor.black:
        textColor = Colors.white;

      case ButtonColor.secondary:
        textColor = Colors.white;

      case ButtonColor.lightGray:
      case ButtonColor.white:
      case ButtonColor.custom:
        textColor = Colors.black;
    }

    if (status == ButtonStatus.disabled) {
      return isFilled
          ? AppSemanticColors.bgInteractiveQuaternary
          : AppSemanticColors.bgInteractiveQuaternary;
    }
    if (status == ButtonStatus.highlighted) {
      return isFilled
          ? textColor
          : _getBackgroundColor().withValues(alpha: 0.8);
    }
    return isFilled ? textColor : _getBackgroundColor();
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.s:
        return const EdgeInsets.all(7);
      case ButtonSize.m:
        return const EdgeInsets.all(9);
      case ButtonSize.l:
        return const EdgeInsets.all(12);
      case ButtonSize.xl:
        return const EdgeInsets.all(15);
    }
  }

  OutlinedBorder _getButtonShape(IconButtonShape shape, bool radiusFull) {
    switch (shape) {
      case IconButtonShape.circle:
        return const CircleBorder();
      case IconButtonShape.rectangle:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull ? 20 : 8),
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.s:
        return 16;
      case ButtonSize.m:
        return 20;
      case ButtonSize.l:
        return 24;
      case ButtonSize.xl:
        return 28;
    }
  }
}
