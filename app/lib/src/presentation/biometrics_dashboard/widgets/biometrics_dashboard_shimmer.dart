import 'package:app_ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BiometricsDashboardShimmer extends StatelessWidget {
  const BiometricsDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards shimmer
          Row(
            children: [
              Expanded(child: _buildShimmerCard()),
              const SizedBox(width: 12),
              Expanded(child: _buildShimmerCard()),
              const SizedBox(width: 12),
              Expanded(child: _buildShimmerCard()),
            ],
          ),
          const SizedBox(height: 24),

          // Controls shimmer
          Row(
            children: [
              Expanded(child: _buildShimmerButton()),
              const SizedBox(width: 12),
              Expanded(child: _buildShimmerButton()),
              const SizedBox(width: 12),
              Expanded(child: _buildShimmerButton()),
              const SizedBox(width: 12),
              _buildShimmerSwitch(),
            ],
          ),
          const SizedBox(height: 24),

          // Charts shimmer
          _buildShimmerChart(),
          const SizedBox(height: 16),
          _buildShimmerChart(),
          const SizedBox(height: 16),
          _buildShimmerChart(),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: AppPrimitiveColors.gray600,
      highlightColor: AppPrimitiveColors.gray700,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppSemanticColors.bgPrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppSemanticColors.borderPrimary),
        ),
      ),
    );
  }

  Widget _buildShimmerButton() {
    return Shimmer.fromColors(
      baseColor: AppPrimitiveColors.gray600,
      highlightColor: AppPrimitiveColors.gray700,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppSemanticColors.bgPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppSemanticColors.borderPrimary),
        ),
      ),
    );
  }

  Widget _buildShimmerSwitch() {
    return Shimmer.fromColors(
      baseColor: AppPrimitiveColors.gray600,
      highlightColor: AppPrimitiveColors.gray700,
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: AppSemanticColors.bgPrimary,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppSemanticColors.borderPrimary),
        ),
      ),
    );
  }

  Widget _buildShimmerChart() {
    return Shimmer.fromColors(
      baseColor: AppPrimitiveColors.gray600,
      highlightColor: AppPrimitiveColors.gray700,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppSemanticColors.bgPrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppSemanticColors.borderPrimary),
        ),
      ),
    );
  }
}
