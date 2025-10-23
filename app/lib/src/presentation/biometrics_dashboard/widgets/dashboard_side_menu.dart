import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class DashboardSideMenu extends StatelessWidget {
  const DashboardSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(color: AppPrimitiveColors.gray800),
      child: Column(
        children: [
          // Top padding for status bar
          SizedBox(height: MediaQuery.of(context).padding.top),
          // User profile section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User icon and name
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppSemanticColors.bgInteractivePrimary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppSemanticColors.fontIconInverse,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.userName,
                            style: AppTextStyle.h5.copyWith(
                              color: AppSemanticColors.fontIconInverse,
                            ),
                          ),
                          Text(
                            context.l10n.userEmail,
                            style: AppTextStyle.text3.copyWith(
                              color: AppSemanticColors.fontIconQuaternary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
