import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTextStyle {
  static const pretendardFontFamily = 'Pretendard';
  static const gowunBatangFontFamily = 'GowunBatang';

  static TextStyle get gowunBatang {
    return _baseTextStyle.copyWith(
      fontFamily: 'GowunBatang',
    );
  }

  static const _baseTextStyle = TextStyle(
    fontFamily: 'Pretendard',
    color: AppSemanticColors.fontIconPrimary,
    fontWeight: AppFontWeight.bold,
    height: 1.5,
  );

  // Display Text Styles
  static TextStyle get d1 {
    return _baseTextStyle.copyWith(
      fontSize: 72,
      height: 1.5,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get d2 {
    return _baseTextStyle.copyWith(
      fontSize: 64,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get d3 {
    return _baseTextStyle.copyWith(
      fontSize: 56,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get d4 {
    return _baseTextStyle.copyWith(
      fontSize: 48,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get d5 {
    return _baseTextStyle.copyWith(
      fontSize: 40,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get d6 {
    return _baseTextStyle.copyWith(
      fontSize: 36,
      fontWeight: AppFontWeight.bold,
    );
  }

  // Headings Text Styles
  static TextStyle get h1 {
    return _baseTextStyle.copyWith(
      fontSize: 32,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get h2 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get h3 {
    return _baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get h4 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get h5 {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: AppFontWeight.bold,
    );
  }

  static TextStyle get h6 {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: AppFontWeight.bold,
    );
  }

  // Body Text Styles
  static TextStyle get p1 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get p2 {
    return _baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get p3 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get p4 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get p5 {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get p6 {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: AppFontWeight.regular,
    );
  }

  // Text Styles
  static TextStyle get text1 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get text2 {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get text3 {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      height: 1,
      fontWeight: AppFontWeight.regular,
    );
  }

  static TextStyle get text4 {
    return _baseTextStyle.copyWith(
      fontSize: 10,
      height: 1,
      fontWeight: AppFontWeight.regular,
    );
  }

  // Button Text Styles
  static TextStyle get button1 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 1,
      fontWeight: AppFontWeight.medium,
    );
  }

  static TextStyle get button2 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1,
      fontWeight: AppFontWeight.medium,
    );
  }

  static TextStyle get button3 {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1,
      fontWeight: AppFontWeight.medium,
    );
  }

  static TextStyle get button4 {
    return _baseTextStyle.copyWith(
      fontSize: 12,
      height: 1,
      fontWeight: AppFontWeight.medium,
    );
  }

  // Custom Text Style
  static TextStyle get custom {
    return _baseTextStyle.copyWith();
  }
}
