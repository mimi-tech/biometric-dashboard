import 'package:flutter/material.dart';

abstract class AppPrimitiveColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightBrown = Color(0xFF9F8D7E);

  // gray colors
  static const Color gray50 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFEEEEEE);
  static const Color gray200 = Color(0xFFDDCDCD);
  static const Color gray300 = Color(0xFFBBBBBB);
  static const Color gray400 = Color(0xFF9E9E9E);
  static const Color gray500 = Color(0xFF7C7C7C);
  static const Color gray600 = Color(0xFF5E5E5E);
  static const Color gray700 = Color(0xFF4C4C4C);
  static const Color gray800 = Color(0xFF1d2024);
  static const Color gray900 = Color(0xFF15171b);

  // orange colors
  static const Color orange50 = Color(0xFFFFEDE6);
  static const Color orange100 = Color(0xFFFFD1B3);
  static const Color orange200 = Color(0xFFFFB380);
  static const Color orange300 = Color(0xFFFF944D);
  static const Color orange400 = Color(0xFFFF6F26);
  static const Color orange500 = Color(0xFFFF4500); // Base
  static const Color orange600 = Color(0xFFE63E00);
  static const Color orange700 = Color(0xFFB83200);
  static const Color orange800 = Color(0xFF8A2600);
  static const Color orange900 = Color(0xFF5C1900);

  // denim colors
  static const Color denim50 = Color(0xFFF5F9FD);
  static const Color denim100 = Color(0xFFE7EFF8);
  static const Color denim200 = Color(0xFFD0DEF0);
  static const Color denim300 = Color(0xFFB4C0E5);
  static const Color denim400 = Color(0xFF90A0D0);
  static const Color denim500 = Color(0xFF6B7EC1);
  static const Color denim600 = Color(0xFF5264AE);
  static const Color denim700 = Color(0xFF424E85);
  static const Color denim800 = Color(0xFF303A5F);
  static const Color denim900 = Color(0xFF252A41);

  // green colors
  static const Color green50 = Color(0xFFF8F9F4);
  static const Color green100 = Color(0xFFEFF2E2);
  static const Color green200 = Color(0xFFDDE5BD);
  static const Color green300 = Color(0xFFBECC91);
  static const Color green400 = Color(0xFFA0B565);
  static const Color green500 = Color(0xFF81993A);
  static const Color green600 = Color(0xFF697B37);
  static const Color green700 = Color(0xFF4F5D2E);
  static const Color green800 = Color(0xFF3C4823);
  static const Color green900 = Color(0xFF293219);

  // tealBlue colors
  static const Color tealBlue50 = Color(0xFFE0F2F7);
  static const Color tealBlue100 = Color(0xFFB3DDEB);
  static const Color tealBlue200 = Color(0xFF80C6DD);
  static const Color tealBlue300 = Color(0xFF4DAFCF);
  static const Color tealBlue400 = Color(0xFF269DBF);
  static const Color tealBlue500 = Color(0xFF008CB0);
  static const Color tealBlue600 = Color(0xFF00779A);
  static const Color tealBlue700 = Color(0xFF006180);
  static const Color tealBlue800 = Color(0xFF004A65);
  static const Color tealBlue900 = Color(0xFF002F44);

  // gold colors
  static const Color gold50 = Color(0xFFFFF8E1);
  static const Color gold100 = Color(0xFFFFECB3);
  static const Color gold200 = Color(0xFFFFE082);
  static const Color gold300 = Color(0xFFFFD54F);
  static const Color gold400 = Color(0xFFFFCA28);
  static const Color gold500 = Color(0xFFFFBC00);
  static const Color gold600 = Color(0xFFE6A800);
  static const Color gold700 = Color(0xFFCC9400);
  static const Color gold800 = Color(0xFF996F00);
  static const Color gold900 = Color(0xFF664B00);

// aqua colors
  static const Color aqua50 = Color(0xFFE0FBF6);
  static const Color aqua100 = Color(0xFFB3F4E8);
  static const Color aqua200 = Color(0xFF80EDD9);
  static const Color aqua300 = Color(0xFF4DE6CA);
  static const Color aqua400 = Color(0xFF26E0BE);
  static const Color aqua500 = Color(0xFF0BD8AF);
  static const Color aqua600 = Color(0xFF00BD99);
  static const Color aqua700 = Color(0xFF009E80);
  static const Color aqua800 = Color(0xFF007E66);
  static const Color aqua900 = Color(0xFF005C4A);

  // purple colors
  static const Color purple50 = Color(0xFFFAF9FC);
  static const Color purple100 = Color(0xFFF2EAF8);
  static const Color purple200 = Color(0xFFE5D3F3);
  static const Color purple300 = Color(0xFFD1B7E5);
  static const Color purple400 = Color(0xFFBA93D7);
  static const Color purple500 = Color(0xFF9F72BB);
  static const Color purple600 = Color(0xFF8754A8);
  static const Color purple700 = Color(0xFF694481);
  static const Color purple800 = Color(0xFF4E305F);
  static const Color purple900 = Color(0xFF3B1F4A);

  // red colors
  static const Color red50 = Color(0xFFFDF7F5);
  static const Color red100 = Color(0xFFFDE0DB);
  static const Color red200 = Color(0xFFFECEC8);
  static const Color red300 = Color(0xFFF3A39C);
  static const Color red400 = Color(0xFFEC7B71);
  static const Color red500 = Color(0xFFE75454);
  static const Color red600 = Color(0xFFD33E3E);
  static const Color red700 = Color(0xFFA33A3A);
  static const Color red800 = Color(0xFF692B2F);
  static const Color red900 = Color(0xFF3B1618);

  // b-alpha colors
  static const Color bAlpha3 = Color(0x08000000); // 3%
  static const Color bAlpha5 = Color(0x0D000000); // 5%
  static const Color bAlpha10 = Color(0x1A000000); // 10%
  static const Color bAlpha20 = Color(0x33000000); // 20%
  static const Color bAlpha30 = Color(0x4D000000); // 30%
  static const Color bAlpha40 = Color(0x66000000); // 40%
  static const Color bAlpha50 = Color(0x80000000); // 50%
  static const Color bAlpha60 = Color(0x99000000); // 60%
  static const Color bAlpha70 = Color(0xB3000000); // 70%
  static const Color bAlpha80 = Color(0xCC000000); // 80%

  // w-alpha colors
  static const Color wAlpha3 = Color(0x05FFFFFF); // 3%
  static const Color wAlpha5 = Color(0x0DFFFFFF); // 5%
  static const Color wAlpha10 = Color(0x1AFFFFFF); // 10%
  static const Color wAlpha20 = Color(0x33FFFFFF); // 20%
  static const Color wAlpha30 = Color(0x4DFFFFFF); // 30%
  static const Color wAlpha40 = Color(0x66FFFFFF); // 40%
  static const Color wAlpha50 = Color(0x80FFFFFF); // 50%
  static const Color wAlpha60 = Color(0x99FFFFFF); // 60%
  static const Color wAlpha70 = Color(0xB3FFFFFF); // 70%
  static const Color wAlpha80 = Color(0xCCFFFFFF); // 80%

  // system colors
  static const Color system100 = Color(0xFF007AFF);
  static const Color system200 = Color(0xFFFF3B30);
}
