import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

enum TabBarSize {
  s,
  m,
}

enum TabBarType {
  solid,
  line,
  mainWhite,
  mainBlack,
  text,
}

class AppTabBar extends StatelessWidget {
  const AppTabBar.solid({
    required List<Tab> tabs,
    TabBarSize size = TabBarSize.m,
    TabController? tabController,
    EdgeInsetsGeometry tabHeaderPadding = EdgeInsets.zero,
    TabAlignment? tabAlignment,
    Color? backgroundColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
    Color? unSelectedTabBorderColor,
    Color? selectedTabBackgroundColor,
    Color? unselectedTabBackgroundColor,
    TabBarIndicatorSize? indicatorSize,
    Key? key,
  }) : this._internal(
          key: key,
          tabs: tabs,
          size: size,
          tabController: tabController,
          tabHeaderPadding: tabHeaderPadding,
          tabAlignment: tabAlignment ?? TabAlignment.start,
          backgroundColor: backgroundColor ?? Colors.transparent,
          selectedLabelColor:
              selectedLabelColor ?? AppSemanticColors.fontIconInverse,
          unselectedLabelColor:
              unselectedLabelColor ?? AppSemanticColors.fontIconSecondary,
          indicatorCustomColor: indicatorColor ?? Colors.transparent,
          type: TabBarType.solid,
          unSelectedTabBorderColor:
              unSelectedTabBorderColor ?? Colors.transparent,
          selectedTabBackgroundColor: selectedTabBackgroundColor,
          unselectedTabBackgroundColor: unselectedTabBackgroundColor,
          indicatorSize: indicatorSize,
        );

  const AppTabBar.line({
    required List<Tab> tabs,
    TabBarSize size = TabBarSize.m,
    TabController? tabController,
    EdgeInsetsGeometry tabHeaderPadding = EdgeInsets.zero,
    TabAlignment? tabAlignment,
    Color? backgroundColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
    TabBarIndicatorSize? indicatorSize,
    Key? key,
  }) : this._internal(
          key: key,
          tabs: tabs,
          size: size,
          tabController: tabController,
          tabHeaderPadding: tabHeaderPadding,
          tabAlignment: tabAlignment ?? TabAlignment.fill,
          backgroundColor: backgroundColor ?? Colors.transparent,
          selectedLabelColor:
              selectedLabelColor ?? AppSemanticColors.fontIconPrimary,
          unselectedLabelColor:
              unselectedLabelColor ?? AppSemanticColors.fontIconSecondary,
          indicatorCustomColor:
              indicatorColor ?? AppSemanticColors.borderInteractiveQuinary,
          type: TabBarType.line,
          indicatorSize: indicatorSize,
        );

  const AppTabBar.mainWhite({
    required List<Tab> tabs,
    TabBarSize size = TabBarSize.m,
    TabController? tabController,
    EdgeInsetsGeometry tabHeaderPadding = EdgeInsets.zero,
    TabAlignment? tabAlignment,
    Color? backgroundColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
    Key? key,
  }) : this._internal(
          key: key,
          tabs: tabs,
          size: size,
          tabController: tabController,
          tabHeaderPadding: tabHeaderPadding,
          tabAlignment: tabAlignment ?? TabAlignment.fill,
          backgroundColor: backgroundColor ?? Colors.transparent,
          selectedLabelColor:
              selectedLabelColor ?? AppSemanticColors.fontIconInverse,
          unselectedLabelColor:
              unselectedLabelColor ?? AppSemanticColors.fontIconInverse,
          indicatorCustomColor:
              indicatorColor ?? AppSemanticColors.borderInverse,
          type: TabBarType.mainWhite,
        );

  const AppTabBar.mainBlack({
    required List<Tab> tabs,
    TabBarSize size = TabBarSize.m,
    TabController? tabController,
    EdgeInsetsGeometry tabHeaderPadding = EdgeInsets.zero,
    TabAlignment? tabAlignment,
    Color? backgroundColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Color? indicatorColor,
    TabBarIndicatorSize? indicatorSize,
    Key? key,
  }) : this._internal(
          key: key,
          tabs: tabs,
          size: size,
          tabController: tabController,
          tabHeaderPadding: tabHeaderPadding,
          tabAlignment: tabAlignment ?? TabAlignment.fill,
          backgroundColor: backgroundColor ?? Colors.transparent,
          selectedLabelColor: selectedLabelColor ??
              AppSemanticColors.fontIconInteractiveQuinary,
          unselectedLabelColor:
              unselectedLabelColor ?? AppSemanticColors.fontIconTertiary,
          indicatorCustomColor:
              indicatorColor ?? AppSemanticColors.borderInteractiveQuinary,
          type: TabBarType.mainBlack,
          indicatorSize: indicatorSize,
        );

  const AppTabBar.text({
    required List<Tab> tabs,
    TabBarSize size = TabBarSize.m,
    TabController? tabController,
    EdgeInsetsGeometry tabHeaderPadding = EdgeInsets.zero,
    TabAlignment? tabAlignment,
    Color? backgroundColor,
    Color? selectedLabelColor,
    Color? unselectedLabelColor,
    Key? key,
  }) : this._internal(
          key: key,
          tabs: tabs,
          size: size,
          tabAlignment: tabAlignment ?? TabAlignment.start,
          tabController: tabController,
          tabHeaderPadding: tabHeaderPadding,
          backgroundColor: backgroundColor ?? Colors.transparent,
          selectedLabelColor:
              selectedLabelColor ?? AppSemanticColors.fontIconPrimary,
          unselectedLabelColor:
              unselectedLabelColor ?? AppSemanticColors.fontIconQuaternary,
          indicatorCustomColor: Colors.transparent,
          type: TabBarType.text,
        );

  const AppTabBar._internal({
    required this.tabs,
    required this.size,
    required this.type,
    required this.backgroundColor,
    required this.tabAlignment,
    this.tabController,
    this.tabHeaderPadding = EdgeInsets.zero,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.indicatorCustomColor,
    this.unSelectedTabBorderColor,
    this.selectedTabBackgroundColor,
    this.unselectedTabBackgroundColor,
    super.key,
    this.indicatorSize,
  });

  final List<Tab> tabs;
  final TabController? tabController;
  final TabBarSize size;
  final TabAlignment tabAlignment;
  final EdgeInsetsGeometry tabHeaderPadding;
  final Color? backgroundColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorCustomColor;
  final Color? unSelectedTabBorderColor;
  final TabBarType type;
  final Color? selectedTabBackgroundColor;
  final Color? unselectedTabBackgroundColor;
  final TabBarIndicatorSize? indicatorSize;

  @override
  Widget build(BuildContext context) {
    final isSmall = size == TabBarSize.s;

    final selectedStyle = isSmall ? AppTextStyle.h6 : AppTextStyle.h5;
    final unselectedStyle = isSmall ? AppTextStyle.h6 : AppTextStyle.h5;

    Decoration indicator;
    TabBarIndicatorSize newIndicatorSize;

    EdgeInsetsGeometry indicatorPadding;

    switch (type) {
      case TabBarType.solid:
        indicator = BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: unSelectedTabBorderColor != null
              ? Border.all(
                  color: unSelectedTabBorderColor!,
                )
              : null,
          color: AppSemanticColors.bgInverse,
        );
        newIndicatorSize = TabBarIndicatorSize.tab;
        indicatorPadding = const EdgeInsets.all(4);
      case TabBarType.line:
      case TabBarType.mainWhite:
      case TabBarType.mainBlack:
        indicator = UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: indicatorCustomColor!,
          ),
        );
        newIndicatorSize = TabBarIndicatorSize.label;
        indicatorPadding = EdgeInsets.zero;

      case TabBarType.text:
        indicator = const BoxDecoration();
        newIndicatorSize = TabBarIndicatorSize.label;
        indicatorPadding = EdgeInsets.zero;
    }

    return Container(
      height: isSmall ? 45 : 52,
      padding: tabHeaderPadding,
      color: backgroundColor,
      child: TabBar(
        tabs: tabs,
        controller: tabController,
        labelStyle: selectedStyle,
        unselectedLabelStyle: unselectedStyle,
        labelColor: selectedLabelColor,
        unselectedLabelColor: unselectedLabelColor,
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        indicatorSize: indicatorSize ?? newIndicatorSize,
        splashBorderRadius: BorderRadius.zero,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        indicator: indicator,
        indicatorPadding: indicatorPadding,
        tabAlignment: tabAlignment,
        isScrollable: tabAlignment != TabAlignment.fill,
        labelPadding: EdgeInsets.zero,
      ),
    );
  }
}
