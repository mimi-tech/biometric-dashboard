// ignore_for_file: unused_element_parameter

import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar._({
    this.title,
    this.backgroundColor = Colors.white,
    this.titleColor,
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
    VoidCallback? onNotificationTap,
    Color? backButtonColor,
  }) {
    return CustomAppBar._(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showNotificationButton: true,
      showMenuButton: true,
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
    Color? titleColor,
  }) {
    return CustomAppBar._(
      title: title,
      titleColor: titleColor,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showBackButton: true,
      action: action,
      backButtonColor: backButtonColor,
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
  }) {
    return CustomAppBar._(
      title: title,
      backgroundColor: backgroundColor,
      scrolledUnderElevation: scrolledUnderElevation,
      showCloseButton: true,
      action: action,
      titleSpacing: titleSpacing,
      backButtonColor: backButtonColor,
    );
  }

  // Right text variant - back button, title, right text
  factory CustomAppBar.rightText({
    required String title,
    required String rightText,
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
  final Color? titleColor;
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
              style: AppTextStyle.gowunBatang.copyWith(
                fontSize: 14,
                fontWeight: AppFontWeight.bold,
                color: titleColor,
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
            if (showNotificationButton) ...[
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: notificationIconColor,
                    ),
                    onPressed: onNotificationTap,
                  ),
                  if (notificationCount != null && notificationCount! > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: notificationBadgeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          notificationCount! > 99
                              ? '99+'
                              : notificationCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
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
