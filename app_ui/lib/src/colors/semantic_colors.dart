import 'package:app_ui/src/colors/primitive_colors.dart';
import 'package:flutter/material.dart';

abstract class AppSemanticColors {
  // primary colors
  static const Color prPrimary = AppPrimitiveColors.orange600;
  static const Color prInverse = AppPrimitiveColors.white;
  static const Color prText = AppPrimitiveColors.orange800;
  static const Color prBorder = AppPrimitiveColors.orange200;
  static const Color prBg = AppPrimitiveColors.orange50;

  // secondary colors
  static const Color sePrimary = AppPrimitiveColors.denim700;
  static const Color seInverse = AppPrimitiveColors.white;
  static const Color seText = AppPrimitiveColors.denim800;
  static const Color seBorder = AppPrimitiveColors.denim100;
  static const Color seBg = AppPrimitiveColors.denim50;

  // tertiary colors
  static const Color tePrimary = AppPrimitiveColors.green600;
  static const Color teInverse = AppPrimitiveColors.white;
  static const Color teText = AppPrimitiveColors.green700;
  static const Color teBorder = AppPrimitiveColors.green100;
  static const Color teBg = AppPrimitiveColors.green50;

  // background colors
  static const Color bgPrimary = AppPrimitiveColors.white;
  static const Color bgSecondary = prBg;
  static const Color bgTertiary = seBg;
  static const Color bgQuaternary = teBg;
  static const Color bgQuinary = AppPrimitiveColors.gray50;
  static const Color bgInverse = AppPrimitiveColors.gray900;
  static const Color bgInteractivePrimary = prPrimary;
  static const Color bgInteractiveSecondary = sePrimary;
  static const Color bgInteractiveTertiary = AppPrimitiveColors.gray700;
  static const Color bgInteractiveQuaternary = AppPrimitiveColors.gray100;
  static const Color bgInteractiveQuinary = AppPrimitiveColors.gray200;
  static const Color bgDim = AppPrimitiveColors.bAlpha40;
  static const Color bgDimBottomsheet = AppPrimitiveColors.bAlpha20;
  static const Color bgBtnHover = AppPrimitiveColors.bAlpha20;
  static const Color bgTableHover = AppPrimitiveColors.bAlpha5;

  // font and icon colors
  static const Color fontIconPrimary = AppPrimitiveColors.gray900;
  static const Color fontIconSecondary = AppPrimitiveColors.gray700;
  static const Color fontIconTertiary = AppPrimitiveColors.gray500;
  static const Color fontIconQuaternary = AppPrimitiveColors.gray300;
  static const Color fontIconQuinary = AppPrimitiveColors.gray200;
  static const Color fontIconInverse = AppPrimitiveColors.white;
  static const Color fontIconInteractivePrimary = prPrimary;
  static const Color fontIconInteractiveSecondary = sePrimary;
  static const Color fontIconInteractiveTertiary = tePrimary;
  static const Color fontIconInteractiveQuaternary = AppPrimitiveColors.gray300;
  static const Color fontIconInteractiveQuinary = AppPrimitiveColors.gray700;

  // border colors
  static const Color borderPrimary = AppPrimitiveColors.gray100;
  static const Color borderSecondary = AppPrimitiveColors.gray200;
  static const Color borderTertiary = AppPrimitiveColors.gray500;
  static const Color borderQuaternary = AppPrimitiveColors.gray700;
  static const Color borderQuinary = AppPrimitiveColors.gray900;
  static const Color borderInverse = AppPrimitiveColors.white;
  static const Color borderInteractivePrimary = prPrimary;
  static const Color borderInteractiveSecondary = sePrimary;
  static const Color borderInteractiveTertiary = tePrimary;
  static const Color borderInteractiveQuaternary = AppPrimitiveColors.gray200;
  static const Color borderInteractiveQuinary = AppPrimitiveColors.gray700;

  // feedback colors
  static const Color feedbackSuccess = AppPrimitiveColors.green400;
  static const Color feedbackWarning = AppPrimitiveColors.orange400;
  static const Color feedbackDanger = AppPrimitiveColors.red600;
}
