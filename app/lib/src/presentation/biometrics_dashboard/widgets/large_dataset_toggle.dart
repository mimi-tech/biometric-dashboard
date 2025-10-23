import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LargeDatasetToggle extends StatelessWidget {
  const LargeDatasetToggle({
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.largeDataset,
          style: AppTextStyle.p4.fontIconInverse.bold,
        ),
        const SizedBox(width: 8),
        Switch(
          value: enabled,
          onChanged: onChanged,
          activeThumbColor: AppSemanticColors.prPrimary,
          inactiveThumbColor: AppSemanticColors.fontIconQuaternary,
          inactiveTrackColor: AppSemanticColors.borderQuaternary,
          activeTrackColor: AppSemanticColors.prPrimary.withValues(
            alpha: 0.3,
          ), // Green active track
        ),
      ],
    );
  }
}
