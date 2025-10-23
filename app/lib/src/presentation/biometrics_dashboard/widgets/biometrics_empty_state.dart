import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BiometricsEmptyState extends StatelessWidget {
  const BiometricsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.analytics_outlined,
            size: 64,
            color: AppSemanticColors.fontIconSecondary,
          ),
          const SizedBox(height: 16),
          Text(context.l10n.noDataAvailable, style: AppTextStyle.h4),
          const SizedBox(height: 8),
          Text(
            context.l10n.noDataAvailableDescription,
            style: AppTextStyle.p3.fontIconSecondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
