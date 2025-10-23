// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Counter';

  @override
  String get biometricsDashboardTitle => 'Biometrics Dashboard';

  @override
  String get noDataAvailable => 'No Data Available';

  @override
  String get noDataAvailableDescription =>
      'There is no biometric data to display at the moment.';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get anErrorOccurred => 'An error occurred';

  @override
  String hrvAvg(String period) {
    return 'HRV Avg ($period)';
  }

  @override
  String rhrAvg(String period) {
    return 'RHR Avg ($period)';
  }

  @override
  String stepsTotal(String period) {
    return 'Steps Total ($period)';
  }

  @override
  String get largeDataset => 'Large Dataset';

  @override
  String get dateRange7d => '7d';

  @override
  String get dateRange30d => '30d';

  @override
  String get dateRange90d => '90d';

  @override
  String get hrv => 'HRV';

  @override
  String get hrvMs => 'HRV (ms)';

  @override
  String get rhr => 'RHR';

  @override
  String get rhrBpm => 'RHR (bpm)';

  @override
  String get steps => 'Steps';

  @override
  String hrvTooltip(String date, String value, String mean, String stdDev) {
    return '$date\nHRV $value ms\nMean $mean ms\nStd Dev $stdDev';
  }

  @override
  String rhrTooltip(String date, String value) {
    return '$date\nRHR $value bpm';
  }

  @override
  String stepsTooltip(String date, String value) {
    return '$date\nSteps $value';
  }

  @override
  String get userName => 'John Doe';

  @override
  String get userEmail => 'john.doe@example.com';
}
