import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BiometricsErrorState extends StatelessWidget {
  const BiometricsErrorState({
    required this.errorMessage,
    required this.onRetry,
    super.key,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppSemanticColors.feedbackDanger,
          ),
          const SizedBox(height: AppPadding.xxl),
          Text(context.l10n.somethingWentWrong, style: AppTextStyle.h4),
          const SizedBox(height: AppPadding.l),
          Text(
            errorMessage,
            style: AppTextStyle.p3.fontIconSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppPadding.xxxxxl),
          AppButton(label: context.l10n.retry, onPressed: onRetry),
        ],
      ),
    );
  }
}
