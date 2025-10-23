import 'package:biometric_app/l10n/l10n.dart';

enum DateRange {
  days7('7d'),
  days30('30d'),
  days90('90d');

  const DateRange(this.label);
  final String label;

  int get days {
    switch (this) {
      case DateRange.days7:
        return 7;
      case DateRange.days30:
        return 30;
      case DateRange.days90:
        return 90;
    }
  }

  String getLocalizedLabel(AppLocalizations l10n) {
    switch (this) {
      case DateRange.days7:
        return l10n.dateRange7d;
      case DateRange.days30:
        return l10n.dateRange30d;
      case DateRange.days90:
        return l10n.dateRange90d;
    }
  }
}
