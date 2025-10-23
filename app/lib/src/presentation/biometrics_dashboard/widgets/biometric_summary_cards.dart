import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:flutter/material.dart';

class BiometricSummaryCards extends StatelessWidget {
  const BiometricSummaryCards({required this.summary, super.key});

  final BiometricSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: context.l10n.hrvAvg(summary.period),
            value: '${summary.hrvAverage.toStringAsFixed(1)} ms',
            color: AppSemanticColors.tePrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: context.l10n.rhrAvg(summary.period),
            value: '${summary.rhrAverage.toStringAsFixed(0)} bpm',
            color: AppSemanticColors.sePrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: context.l10n.stepsTotal(summary.period),
            value: summary.stepsTotal.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            ),
            color: AppSemanticColors.feedbackWarning,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppPrimitiveColors.gray800,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [AppShadows.depth1],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.text3.fontIconInverse.bold),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyle.h4.fontIconInverse.bold),
        ],
      ),
    );
  }
}
