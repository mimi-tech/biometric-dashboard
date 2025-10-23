import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

// Button Color Variants
enum ButtonColor { primary, secondary, black, lightGray, white, custom }

// Button Size Variants
enum ButtonSize { s, m, l, xl }

// Button State
enum ButtonState { active, disabled }

class ButtonStyleConfig {
  const ButtonStyleConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.padding,
    required this.textStyle,
    required this.opacity,
  });
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final double borderRadius;
  final double? opacity;
  final EdgeInsets padding;
  final TextStyle textStyle;

  ButtonStyleConfig copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    double? borderWidth,
    double? borderRadius,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? opacity,
  }) {
    return ButtonStyleConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      opacity: opacity ?? this.opacity,
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.color = ButtonColor.primary,
    this.size = ButtonSize.m,
    this.state = ButtonState.active,
    this.fill = true,
    this.radiusFull = false,
    this.iconLeft,
    this.iconRight,
    this.opacity,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonColor color;
  final double? opacity;
  final ButtonSize size;
  final ButtonState state;
  final bool fill;
  final bool radiusFull;
  final Widget? iconLeft;
  final Widget? iconRight;

  @override
  Widget build(BuildContext context) {
    final config = _getButtonStyleConfig();
    final isDisabled = state == ButtonState.disabled || onPressed == null;
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconLeft != null) ...[
          iconLeft!,
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            label,
            style: config.textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (iconRight != null) ...[
          const SizedBox(width: 6),
          iconRight!,
        ],
      ],
    );
    final style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (isDisabled) return AppPrimitiveColors.gray100;
        return fill ? config.backgroundColor : Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.all<Color>(config.textColor),
      overlayColor: WidgetStateProperty.all<Color>(
        fill
            ? config.backgroundColor.withValues(alpha: 0.85)
            : config.borderColor.withValues(alpha: 0.08),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(config.padding),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.borderRadius),
          side: BorderSide(
            color: config.borderColor,
            width: config.borderWidth,
          ),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(config.textStyle),
      elevation: WidgetStateProperty.all<double>(0),
    );
    if (fill) {
      return SizedBox(
        height: _getHeight(),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        ),
      );
    } else {
      return SizedBox(
        height: _getHeight(),
        child: OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: child,
        ),
      );
    }
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.s:
        return 30;
      case ButtonSize.m:
        return 40;
      case ButtonSize.l:
        return 48;
      case ButtonSize.xl:
        return 56;
    }
  }

  ButtonStyleConfig _getButtonStyleConfig() {
    Color bgColor;
    Color borderColor;
    Color textColor;
    final borderWidth = fill ? 0.0 : 1.5;
    double radius;

    // Button Color Variants
    switch (color) {
      case ButtonColor.primary:
        bgColor =
            fill ? AppSemanticColors.bgInteractivePrimary : Colors.transparent;
        borderColor = AppSemanticColors.borderInteractivePrimary;
        textColor = fill
            ? AppSemanticColors.fontIconInverse
            : AppSemanticColors.fontIconInteractivePrimary;
      case ButtonColor.secondary:
        bgColor = fill
            ? AppSemanticColors.bgInteractiveSecondary
            : Colors.transparent;
        borderColor = AppSemanticColors.borderInteractiveSecondary;
        textColor = fill
            ? AppSemanticColors.fontIconInverse
            : AppSemanticColors.fontIconInteractiveSecondary;
      case ButtonColor.black:
        bgColor = fill ? AppSemanticColors.bgInverse : Colors.transparent;
        borderColor = AppSemanticColors.borderQuinary;
        textColor = fill
            ? AppSemanticColors.fontIconInverse
            : AppSemanticColors.fontIconPrimary;
      case ButtonColor.lightGray:
        bgColor = fill
            ? AppSemanticColors.bgInteractiveQuaternary
            : Colors.transparent;
        borderColor = AppSemanticColors.borderPrimary;
        textColor = fill
            ? AppSemanticColors.fontIconSecondary
            : AppSemanticColors.fontIconInteractiveQuaternary;
      case ButtonColor.white:
        bgColor = fill
            ? AppSemanticColors.bgPrimary.withValues(alpha: opacity ?? 1.0)
            : Colors.transparent;
        borderColor = AppSemanticColors.borderInverse;
        textColor = fill
            ? opacity != null
                ? AppSemanticColors.fontIconInverse
                : AppSemanticColors.fontIconPrimary
            : AppSemanticColors.fontIconInverse;

      case ButtonColor.custom:
        bgColor = fill ? AppSemanticColors.borderInverse : Colors.transparent;
        borderColor = AppSemanticColors.borderInverse;
        textColor = fill
            ? AppSemanticColors.fontIconInverse
            : AppSemanticColors.fontIconInverse;
    }

    // Button State Variants
    if (state == ButtonState.disabled) {
      bgColor = AppPrimitiveColors.gray100;
      borderColor = AppPrimitiveColors.gray200;
      textColor = AppPrimitiveColors.gray400;
    }
    EdgeInsets padding;
    TextStyle textStyle;

    // Button Size, padding, and text style Variants
    switch (size) {
      case ButtonSize.s:
        padding = EdgeInsets.symmetric(
          horizontal: radiusFull ? AppPadding.l : AppPadding.ml,
          vertical: AppPadding.m,
        );
        textStyle = AppTextStyle.button4;
        radius = AppRadius.xs;
      case ButtonSize.m:
        padding = EdgeInsets.symmetric(
          horizontal: radiusFull ? AppPadding.xxl : AppPadding.l,
          vertical: AppPadding.s,
        );
        textStyle = AppTextStyle.button3;
        radius = AppRadius.m;
      case ButtonSize.l:
        padding = EdgeInsets.symmetric(
          horizontal: radiusFull ? AppPadding.xxxxxl : AppPadding.xxxxl,
          vertical: AppPadding.m,
        );
        textStyle = AppTextStyle.button2;
        radius = AppRadius.l;
      case ButtonSize.xl:
        padding = EdgeInsets.symmetric(
          horizontal: radiusFull ? AppPadding.xxxxxl : AppPadding.xxxxxl,
          vertical: AppPadding.l,
        );
        textStyle = AppTextStyle.button1;
        radius = AppRadius.full;
    }

    // Button Radius and Border Color Variants
    radius = radiusFull ? AppRadius.full : radius;
    borderColor = fill ? bgColor : borderColor;

    return ButtonStyleConfig(
      backgroundColor: bgColor,
      borderColor: borderColor,
      textColor: textColor,
      borderWidth: borderWidth,
      borderRadius: radius,
      padding: padding,
      opacity: opacity,
      textStyle: textStyle.copyWith(color: textColor),
    );
  }
}
