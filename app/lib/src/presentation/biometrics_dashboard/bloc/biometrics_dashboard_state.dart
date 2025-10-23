import 'package:biometric_app/src/core/enum/ui_state.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:equatable/equatable.dart';

class BiometricsDashboardState extends Equatable {
  const BiometricsDashboardState({
    this.uiState = UiState.initial,
    this.biometricData = const [],
    this.journalEntries = const [],
    this.summary = const BiometricSummary(
      hrvAverage: 0,
      rhrAverage: 0,
      stepsTotal: 0,
      period: '7d',
    ),
    this.hrvChartData = const [],
    this.rhrChartData = const [],
    this.stepsChartData = const [],
    this.rollingStats = const [],
    this.selectedRange = DateRange.days7,
    this.largeDatasetEnabled = false,
    this.crosshairDate,
    this.errorMessage,
  });

  final UiState uiState;
  final List<BiometricData> biometricData;
  final List<JournalEntry> journalEntries;
  final BiometricSummary summary;
  final List<ChartDataPoint> hrvChartData;
  final List<ChartDataPoint> rhrChartData;
  final List<ChartDataPoint> stepsChartData;
  final List<RollingStats> rollingStats;
  final DateRange selectedRange;
  final bool largeDatasetEnabled;
  final DateTime? crosshairDate;
  final String? errorMessage;

  BiometricsDashboardState copyWith({
    UiState? uiState,
    List<BiometricData>? biometricData,
    List<JournalEntry>? journalEntries,
    BiometricSummary? summary,
    List<ChartDataPoint>? hrvChartData,
    List<ChartDataPoint>? rhrChartData,
    List<ChartDataPoint>? stepsChartData,
    List<RollingStats>? rollingStats,
    DateRange? selectedRange,
    bool? largeDatasetEnabled,
    DateTime? crosshairDate,
    String? errorMessage,
  }) {
    return BiometricsDashboardState(
      uiState: uiState ?? this.uiState,
      biometricData: biometricData ?? this.biometricData,
      journalEntries: journalEntries ?? this.journalEntries,
      summary: summary ?? this.summary,
      hrvChartData: hrvChartData ?? this.hrvChartData,
      rhrChartData: rhrChartData ?? this.rhrChartData,
      stepsChartData: stepsChartData ?? this.stepsChartData,
      rollingStats: rollingStats ?? this.rollingStats,
      selectedRange: selectedRange ?? this.selectedRange,
      largeDatasetEnabled: largeDatasetEnabled ?? this.largeDatasetEnabled,
      crosshairDate: crosshairDate ?? this.crosshairDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    uiState,
    biometricData,
    journalEntries,
    summary,
    hrvChartData,
    rhrChartData,
    stepsChartData,
    rollingStats,
    selectedRange,
    largeDatasetEnabled,
    crosshairDate,
    errorMessage,
  ];
}
