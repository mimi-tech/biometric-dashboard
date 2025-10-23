import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';

class AppNoDataWidget extends StatelessWidget {
  const AppNoDataWidget({
    this.message,
    this.icon,
    this.description,
    super.key,
  });
  final String? message;
  final IconData? icon;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          if (icon != null) ...[
            SizedBox(child: Icon(icon)),
          ] else ...[
            const Icon(Icons.error),
          ],
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              message ?? 'No data found',
              textAlign: TextAlign.center,
              style: AppTextStyle.p4.fontIconTertiary,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            description ?? '',
            style: AppTextStyle.p5.fontIconQuaternary,
          ),
        ],
      ),
    );
  }
}
