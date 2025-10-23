import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

class CustomScrollableAppBar extends StatelessWidget {
  const CustomScrollableAppBar({
    required this.expandedHeight,
    required this.isScrolled,
    this.scrolledBackgroundColor = AppSemanticColors.fontIconInverse,
    this.title = '',
    this.iconColor = AppSemanticColors.fontIconPrimary,
    this.titleColor = AppSemanticColors.fontIconPrimary,
    this.flexibleSpaceWidgets = const [],
    this.actions = const [],
    this.showBackButton = true,
    super.key,
  });

  final Color titleColor;
  final Color iconColor;
  final Color scrolledBackgroundColor;
  final String title;
  final double expandedHeight;
  final bool isScrolled;
  final bool showBackButton;
  final List<Widget> flexibleSpaceWidgets;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: expandedHeight,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: 20,
                color: iconColor,
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTextStyle.h5.copyWith(
          fontSize: 16,
          color: titleColor,
        ),
      ),
      actions: [
        ...actions,
        const SizedBox(width: AppPadding.xxl),
      ],
      flexibleSpace: Stack(
        fit: StackFit.expand,
        children: [
          ...flexibleSpaceWidgets,

          /// White overlay when scrolled (fake background)
          if (isScrolled)
            Container(
              color: scrolledBackgroundColor,
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
            ),
        ],
      ),
    );
  }
}
