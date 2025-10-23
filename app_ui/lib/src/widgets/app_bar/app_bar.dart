// ignore_for_file: unused_element_parameter

import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
export 'custom_app_bar.dart';
export 'custom_scrollable_app_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar._({
    this.title,
    this.backgroundColor = Colors.white,
    this.notificationBadgeColor,
    this.notificationIconColor,
    this.menuIconColor,
    this.scrolledUnderElevation,
    this.showBackButton = false,
    this.showCloseButton = false,
    this.showMenuButton = false,
    this.showNotificationButton = false,
    this.rightText,
    this.notificationCount,
    this.preferredHeight = 64,
    this.onBackTap,
    this.onMenuTap,
    this.onRightTextTap,
    this.onNotificationTap,
    this.onCloseTap,
    this.action,
    this.titleSpacing,
    this.backButtonColor,
    super.key,
  });

  // Main variant - logo, notification with count, menu
  factory CustomAppBar.main({
    Color backgroundColor = Colors.white,
    double? scrolledUnderElevation,
    int? notificationCount,
    Color? notificationIconColor,
    Color? notificationBadgeColor,
    Color? menuIconColor,
    VoidCallback? onMenuTap,
    VoidCallback? onNotificationTap,
    Color? backButtonColor,
    bool? showNotificationButton,
  }) {
    return CustomAppBar._(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showNotificationButton: showNotificationButton ?? true,
      showMenuButton: true,
      onMenuTap: onMenuTap,
      notificationCount: notificationCount,
      notificationIconColor: notificationIconColor,
      menuIconColor: menuIconColor,
      notificationBadgeColor: notificationBadgeColor,
      onNotificationTap: onNotificationTap,
      backButtonColor: backButtonColor,
    );
  }

  // Sub variant - back button, title, close button
  factory CustomAppBar.sub({
    required String title,
    Color backgroundColor = Colors.white,
    double? scrolledUnderElevation,
    List<Widget>? action,
    Color? backButtonColor,
    VoidCallback? onBackTap,
  }) {
    return CustomAppBar._(
      title: title,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showBackButton: true,
      action: action,
      backButtonColor: backButtonColor,
      onBackTap: onBackTap,
    );
  }

  // Popup variant - title, close button
  factory CustomAppBar.popup({
    required String title,
    Color backgroundColor = Colors.white,
    double? scrolledUnderElevation,
    List<Widget>? action,
    double? titleSpacing,
    Color? backButtonColor,
    VoidCallback? onCloseTap,
  }) {
    return CustomAppBar._(
      title: title,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showCloseButton: true,
      action: action,
      titleSpacing: titleSpacing,
      backButtonColor: backButtonColor,
      onCloseTap: onCloseTap,
    );
  }

  // Right text variant - back button, title, right text
  factory CustomAppBar.rightText({
    required String title,
    required String rightText,
    VoidCallback? onBackTap,
    Color backgroundColor = Colors.white,
    double? scrolledUnderElevation,
    void Function()? onRightTextTap,
    Color? backButtonColor,
  }) {
    return CustomAppBar._(
      title: title,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showBackButton: true,
      rightText: rightText,
      onBackTap: onBackTap,
      onRightTextTap: onRightTextTap,
      backButtonColor: backButtonColor,
    );
  }

  // notification page variant - back button, title, close button
  factory CustomAppBar.notificationPage({
    required String title,
    Color backgroundColor = Colors.white,
    double? scrolledUnderElevation,
  }) {
    return CustomAppBar._(
      title: title,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showCloseButton: true,
      titleSpacing: 16,
    );
  }

  final String? title;
  final double preferredHeight;
  final Color backgroundColor;
  final Color? notificationIconColor;
  final Color? notificationBadgeColor;
  final Color? menuIconColor;
  final double? scrolledUnderElevation;
  final bool showBackButton;
  final bool showCloseButton;
  final bool showMenuButton;
  final bool showNotificationButton;
  final String? rightText;
  final int? notificationCount;
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onRightTextTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCloseTap;
  final List<Widget>? action;
  final double? titleSpacing;
  final Color? backButtonColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: title != null
          ? Text(
              title!,
              style: AppTextStyle.gowunBatang.fontIconInverse.copyWith(
                fontSize: 14,
                fontWeight: AppFontWeight.bold,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: AppPadding.xxxxl),
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 20,
                height: 15,
              ),
            ),
      titleSpacing: titleSpacing ?? 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: scrolledUnderElevation ?? 0,
      leading: showBackButton
          ? InkWell(
              onTap: onBackTap ?? () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: backButtonColor,
              ),
            )
          : null,
      actions: action ??
          [
            if (showMenuButton)
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 20,
                  color: menuIconColor,
                ),
                onPressed: onMenuTap,
              ),
            if (showCloseButton)
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: onCloseTap ?? () => Navigator.pop(context),
              ),
            if (rightText != null)
              TextButton(
                onPressed: onRightTextTap,
                child: Text(
                  rightText!,
                  style:
                      AppTextStyle.button3.fontIconInteractiveSecondary.medium,
                ),
              ),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
