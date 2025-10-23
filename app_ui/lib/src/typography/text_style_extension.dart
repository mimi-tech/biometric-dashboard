import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

extension TextStyleExtensions on TextStyle {
  TextStyle get pretendard =>
      copyWith(fontFamily: AppTextStyle.pretendardFontFamily);
  TextStyle get gowunBatang =>
      copyWith(fontFamily: AppTextStyle.gowunBatangFontFamily);

  TextStyle get transparent => copyWith(color: Colors.transparent);

  // Gray colors
  TextStyle get gray50 => copyWith(color: AppPrimitiveColors.gray50);
  TextStyle get gray100 => copyWith(color: AppPrimitiveColors.gray100);
  TextStyle get gray200 => copyWith(color: AppPrimitiveColors.gray200);
  TextStyle get gray300 => copyWith(color: AppPrimitiveColors.gray300);
  TextStyle get gray400 => copyWith(color: AppPrimitiveColors.gray400);
  TextStyle get gray500 => copyWith(color: AppPrimitiveColors.gray500);
  TextStyle get gray600 => copyWith(color: AppPrimitiveColors.gray600);
  TextStyle get gray700 => copyWith(color: AppPrimitiveColors.gray700);
  TextStyle get gray800 => copyWith(color: AppPrimitiveColors.gray800);
  TextStyle get gray900 => copyWith(color: AppPrimitiveColors.gray900);

  // Denim colors
  TextStyle get denim50 => copyWith(color: AppPrimitiveColors.denim50);
  TextStyle get denim100 => copyWith(color: AppPrimitiveColors.denim100);
  TextStyle get denim200 => copyWith(color: AppPrimitiveColors.denim200);
  TextStyle get denim300 => copyWith(color: AppPrimitiveColors.denim300);
  TextStyle get denim400 => copyWith(color: AppPrimitiveColors.denim400);
  TextStyle get denim500 => copyWith(color: AppPrimitiveColors.denim500);
  TextStyle get denim600 => copyWith(color: AppPrimitiveColors.denim600);
  TextStyle get denim700 => copyWith(color: AppPrimitiveColors.denim700);
  TextStyle get denim800 => copyWith(color: AppPrimitiveColors.denim800);
  TextStyle get denim900 => copyWith(color: AppPrimitiveColors.denim900);

  // Green colors
  TextStyle get green50 => copyWith(color: AppPrimitiveColors.green50);
  TextStyle get green100 => copyWith(color: AppPrimitiveColors.green100);
  TextStyle get green200 => copyWith(color: AppPrimitiveColors.green200);
  TextStyle get green300 => copyWith(color: AppPrimitiveColors.green300);
  TextStyle get green400 => copyWith(color: AppPrimitiveColors.green400);
  TextStyle get green500 => copyWith(color: AppPrimitiveColors.green500);
  TextStyle get green600 => copyWith(color: AppPrimitiveColors.green600);
  TextStyle get green700 => copyWith(color: AppPrimitiveColors.green700);
  TextStyle get green800 => copyWith(color: AppPrimitiveColors.green800);
  TextStyle get green900 => copyWith(color: AppPrimitiveColors.green900);

  // Orange colors
  TextStyle get orange50 => copyWith(color: AppPrimitiveColors.orange50);
  TextStyle get orange100 => copyWith(color: AppPrimitiveColors.orange100);
  TextStyle get orange200 => copyWith(color: AppPrimitiveColors.orange200);
  TextStyle get orange300 => copyWith(color: AppPrimitiveColors.orange300);
  TextStyle get orange400 => copyWith(color: AppPrimitiveColors.orange400);
  TextStyle get orange500 => copyWith(color: AppPrimitiveColors.orange500);
  TextStyle get orange600 => copyWith(color: AppPrimitiveColors.orange600);
  TextStyle get orange700 => copyWith(color: AppPrimitiveColors.orange700);
  TextStyle get orange800 => copyWith(color: AppPrimitiveColors.orange800);
  TextStyle get orange900 => copyWith(color: AppPrimitiveColors.orange900);

  // Purple colors
  TextStyle get purple50 => copyWith(color: AppPrimitiveColors.purple50);
  TextStyle get purple100 => copyWith(color: AppPrimitiveColors.purple100);
  TextStyle get purple200 => copyWith(color: AppPrimitiveColors.purple200);
  TextStyle get purple300 => copyWith(color: AppPrimitiveColors.purple300);
  TextStyle get purple400 => copyWith(color: AppPrimitiveColors.purple400);
  TextStyle get purple500 => copyWith(color: AppPrimitiveColors.purple500);
  TextStyle get purple600 => copyWith(color: AppPrimitiveColors.purple600);
  TextStyle get purple700 => copyWith(color: AppPrimitiveColors.purple700);
  TextStyle get purple800 => copyWith(color: AppPrimitiveColors.purple800);
  TextStyle get purple900 => copyWith(color: AppPrimitiveColors.purple900);

  // Red colors
  TextStyle get red50 => copyWith(color: AppPrimitiveColors.red50);
  TextStyle get red100 => copyWith(color: AppPrimitiveColors.red100);
  TextStyle get red200 => copyWith(color: AppPrimitiveColors.red200);
  TextStyle get red300 => copyWith(color: AppPrimitiveColors.red300);
  TextStyle get red400 => copyWith(color: AppPrimitiveColors.red400);
  TextStyle get red500 => copyWith(color: AppPrimitiveColors.red500);
  TextStyle get red600 => copyWith(color: AppPrimitiveColors.red600);
  TextStyle get red700 => copyWith(color: AppPrimitiveColors.red700);
  TextStyle get red800 => copyWith(color: AppPrimitiveColors.red800);
  TextStyle get red900 => copyWith(color: AppPrimitiveColors.red900);

  // b-alpha
  TextStyle get bAlpha3 => copyWith(color: AppPrimitiveColors.bAlpha3);
  TextStyle get bAlpha5 => copyWith(color: AppPrimitiveColors.bAlpha5);
  TextStyle get bAlpha10 => copyWith(color: AppPrimitiveColors.bAlpha10);
  TextStyle get bAlpha20 => copyWith(color: AppPrimitiveColors.bAlpha20);
  TextStyle get bAlpha30 => copyWith(color: AppPrimitiveColors.bAlpha30);
  TextStyle get bAlpha40 => copyWith(color: AppPrimitiveColors.bAlpha40);
  TextStyle get bAlpha50 => copyWith(color: AppPrimitiveColors.bAlpha50);
  TextStyle get bAlpha60 => copyWith(color: AppPrimitiveColors.bAlpha60);
  TextStyle get bAlpha70 => copyWith(color: AppPrimitiveColors.bAlpha70);
  TextStyle get bAlpha80 => copyWith(color: AppPrimitiveColors.bAlpha80);

  // w-alpha colors
  TextStyle get wAlpha3 => copyWith(color: AppPrimitiveColors.wAlpha3);
  TextStyle get wAlpha5 => copyWith(color: AppPrimitiveColors.wAlpha5);
  TextStyle get wAlpha10 => copyWith(color: AppPrimitiveColors.wAlpha10);
  TextStyle get wAlpha20 => copyWith(color: AppPrimitiveColors.wAlpha20);
  TextStyle get wAlpha30 => copyWith(color: AppPrimitiveColors.wAlpha30);
  TextStyle get wAlpha40 => copyWith(color: AppPrimitiveColors.wAlpha40);
  TextStyle get wAlpha50 => copyWith(color: AppPrimitiveColors.wAlpha50);
  TextStyle get wAlpha60 => copyWith(color: AppPrimitiveColors.wAlpha60);
  TextStyle get wAlpha70 => copyWith(color: AppPrimitiveColors.wAlpha70);
  TextStyle get wAlpha80 => copyWith(color: AppPrimitiveColors.wAlpha80);
}

extension TextStyleFontWeight on TextStyle {
  TextStyle get extraBold => copyWith(fontWeight: AppFontWeight.extraBold);
  TextStyle get bold => copyWith(fontWeight: AppFontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: AppFontWeight.semiBold);
  TextStyle get medium => copyWith(fontWeight: AppFontWeight.medium);
  TextStyle get regular => copyWith(fontWeight: AppFontWeight.regular);
  TextStyle get light => copyWith(fontWeight: AppFontWeight.light);
}

extension TextStyleSemanticColors on TextStyle {
  TextStyle get prPrimary => copyWith(color: AppSemanticColors.prPrimary);
  TextStyle get prInverse => copyWith(color: AppSemanticColors.prInverse);
  TextStyle get prText => copyWith(color: AppSemanticColors.prText);
  TextStyle get prBorder => copyWith(color: AppSemanticColors.prBorder);
  TextStyle get prBg => copyWith(color: AppSemanticColors.prBg);

  TextStyle get sePrimary => copyWith(color: AppSemanticColors.sePrimary);
  TextStyle get seInverse => copyWith(color: AppSemanticColors.seInverse);
  TextStyle get seText => copyWith(color: AppSemanticColors.seText);
  TextStyle get seBorder => copyWith(color: AppSemanticColors.seBorder);
  TextStyle get seBg => copyWith(color: AppSemanticColors.seBg);

  TextStyle get tePrimary => copyWith(color: AppSemanticColors.tePrimary);
  TextStyle get teInverse => copyWith(color: AppSemanticColors.teInverse);
  TextStyle get teText => copyWith(color: AppSemanticColors.teText);
  TextStyle get teBorder => copyWith(color: AppSemanticColors.teBorder);
  TextStyle get teBg => copyWith(color: AppSemanticColors.teBg);

  TextStyle get bgPrimary => copyWith(color: AppSemanticColors.bgPrimary);
  TextStyle get bgSecondary => copyWith(color: AppSemanticColors.bgSecondary);
  TextStyle get bgTertiary => copyWith(color: AppSemanticColors.bgTertiary);
  TextStyle get bgQuaternary => copyWith(color: AppSemanticColors.bgQuaternary);
  TextStyle get bgQuinary => copyWith(color: AppSemanticColors.bgQuinary);
  TextStyle get bgInverse => copyWith(color: AppSemanticColors.bgInverse);
  TextStyle get bgInteractivePrimary =>
      copyWith(color: AppSemanticColors.bgInteractivePrimary);
  TextStyle get bgInteractiveSecondary =>
      copyWith(color: AppSemanticColors.bgInteractiveSecondary);
  TextStyle get bgInteractiveTertiary =>
      copyWith(color: AppSemanticColors.bgInteractiveTertiary);
  TextStyle get bgInteractiveQuaternary =>
      copyWith(color: AppSemanticColors.bgInteractiveQuaternary);
  TextStyle get bgInteractiveQuinary =>
      copyWith(color: AppSemanticColors.bgInteractiveQuinary);
  TextStyle get bgDim => copyWith(color: AppSemanticColors.bgDim);
  TextStyle get bgDimBottomsheet =>
      copyWith(color: AppSemanticColors.bgDimBottomsheet);
  TextStyle get bgBtnHover => copyWith(color: AppSemanticColors.bgBtnHover);
  TextStyle get bgTableHover => copyWith(color: AppSemanticColors.bgTableHover);

  TextStyle get fontIconPrimary =>
      copyWith(color: AppSemanticColors.fontIconPrimary);
  TextStyle get fontIconSecondary =>
      copyWith(color: AppSemanticColors.fontIconSecondary);
  TextStyle get fontIconTertiary =>
      copyWith(color: AppSemanticColors.fontIconTertiary);
  TextStyle get fontIconQuaternary =>
      copyWith(color: AppSemanticColors.fontIconQuaternary);
  TextStyle get fontIconQuinary =>
      copyWith(color: AppSemanticColors.fontIconQuinary);
  TextStyle get fontIconInverse =>
      copyWith(color: AppSemanticColors.fontIconInverse);
  TextStyle get fontIconInteractivePrimary =>
      copyWith(color: AppSemanticColors.fontIconInteractivePrimary);
  TextStyle get fontIconInteractiveSecondary =>
      copyWith(color: AppSemanticColors.fontIconInteractiveSecondary);
  TextStyle get fontIconInteractiveTertiary =>
      copyWith(color: AppSemanticColors.fontIconInteractiveTertiary);
  TextStyle get fontIconInteractiveQuaternary =>
      copyWith(color: AppSemanticColors.fontIconInteractiveQuaternary);
  TextStyle get fontIconInteractiveQuinary =>
      copyWith(color: AppSemanticColors.fontIconInteractiveQuinary);

  TextStyle get borderPrimary =>
      copyWith(color: AppSemanticColors.borderPrimary);
  TextStyle get borderSecondary =>
      copyWith(color: AppSemanticColors.borderSecondary);
  TextStyle get borderTertiary =>
      copyWith(color: AppSemanticColors.borderTertiary);
  TextStyle get borderQuaternary =>
      copyWith(color: AppSemanticColors.borderQuaternary);
  TextStyle get borderQuinary =>
      copyWith(color: AppSemanticColors.borderQuinary);
  TextStyle get borderInverse =>
      copyWith(color: AppSemanticColors.borderInverse);
  TextStyle get borderInteractivePrimary =>
      copyWith(color: AppSemanticColors.borderInteractivePrimary);
  TextStyle get borderInteractiveSecondary =>
      copyWith(color: AppSemanticColors.borderInteractiveSecondary);
  TextStyle get borderInteractiveTertiary =>
      copyWith(color: AppSemanticColors.borderInteractiveTertiary);
  TextStyle get borderInteractiveQuaternary =>
      copyWith(color: AppSemanticColors.borderInteractiveQuaternary);
  TextStyle get borderInteractiveQuinary =>
      copyWith(color: AppSemanticColors.borderInteractiveQuinary);

  TextStyle get feedbackSuccess =>
      copyWith(color: AppSemanticColors.feedbackSuccess);
  TextStyle get feedbackWarning =>
      copyWith(color: AppSemanticColors.feedbackWarning);
  TextStyle get feedbackDanger =>
      copyWith(color: AppSemanticColors.feedbackDanger);
}
