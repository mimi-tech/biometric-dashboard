import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:flutter/material.dart';

class RangeSelector extends StatelessWidget {
  const RangeSelector({
    required this.selectedRange,
    required this.onRangeChanged,
    super.key,
  });

  final DateRange selectedRange;
  final ValueChanged<DateRange> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: DateRange.values.map((range) {
        final isSelected = range == selectedRange;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: range != DateRange.values.last ? 8 : 0,
            ),
            child: GestureDetector(
              onTap: () => onRangeChanged(range),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.l),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppSemanticColors.bgInteractivePrimary
                      : AppPrimitiveColors.gray800,
                  borderRadius: BorderRadius.circular(AppRadius.m),
                ),
                child: Text(
                  range.getLocalizedLabel(context.l10n),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.p4.bold.fontIconInverse,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
