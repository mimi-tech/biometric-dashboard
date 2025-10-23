import 'package:biometric_app/src/core/enum/ui_state.dart';
import 'package:biometric_app/src/core/utils/data_decimator.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_event.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_state.dart';
import 'package:biometric_app/src/repositories/biometric/biometric_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsDashboardBloc
    extends Bloc<BiometricsDashboardEvent, BiometricsDashboardState> {
  BiometricsDashboardBloc({required this.biometricRepository})
    : super(const BiometricsDashboardState()) {
    on<BiometricsDashboardInitialized>(_onInitialized);
    on<BiometricsDashboardRangeChanged>(_onRangeChanged);
    on<BiometricsDashboardLargeDatasetToggled>(_onLargeDatasetToggled);
    on<BiometricsDashboardRetryPressed>(_onRetryPressed);
    on<BiometricsDashboardCrosshairMoved>(_onCrosshairMoved);
  }

  final BiometricRepository biometricRepository;

  Future<void> _onInitialized(
    BiometricsDashboardInitialized event,
    Emitter<BiometricsDashboardState> emit,
  ) async {
    emit(state.copyWith(uiState: UiState.loading));

    try {
      final biometricData = await biometricRepository.getBiometricData();
      final journalEntries = await biometricRepository.getJournalEntries();

      emit(
        state.copyWith(
          biometricData: biometricData,
          journalEntries: journalEntries,
          uiState: UiState.loaded,
        ),
      );

      await _processData(emit);
    } catch (error) {
      emit(
        state.copyWith(
          uiState: UiState.error,
          errorMessage: 'Failed to load data: $error',
        ),
      );
    }
  }

  Future<void> _onRangeChanged(
    BiometricsDashboardRangeChanged event,
    Emitter<BiometricsDashboardState> emit,
  ) async {
    emit(state.copyWith(selectedRange: event.range));
    await _processData(emit);
  }

  Future<void> _onLargeDatasetToggled(
    BiometricsDashboardLargeDatasetToggled event,
    Emitter<BiometricsDashboardState> emit,
  ) async {
    emit(state.copyWith(largeDatasetEnabled: event.enabled));
    await _processData(emit);
  }

  Future<void> _onRetryPressed(
    BiometricsDashboardRetryPressed event,
    Emitter<BiometricsDashboardState> emit,
  ) async {
    add(const BiometricsDashboardInitialized());
  }

  Future<void> _processData(Emitter<BiometricsDashboardState> emit) async {
    try {
      var dataToProcess = state.biometricData;

      // Apply large dataset if enabled
      if (state.largeDatasetEnabled) {
        dataToProcess = biometricRepository.generateLargeDataset(10000);
      }

      // Filter data by selected range
      final now = DateTime.now();
      final startDate = now.subtract(Duration(days: state.selectedRange.days));
      final filteredData = dataToProcess
          .where(
            (data) =>
                data.date.isAfter(startDate) ||
                data.date.isAtSameMomentAs(startDate),
          )
          .toList();

      // Apply decimation for performance
      var processedData = filteredData;
      if (state.selectedRange == DateRange.days30 ||
          state.selectedRange == DateRange.days90) {
        // Convert to chart points, decimate, then convert back
        final chartPoints = processedData
            .map(
              (d) => ChartDataPoint(
                x: d.date.millisecondsSinceEpoch.toDouble(),
                y: d.hrv,
                date: d.date,
              ),
            )
            .toList();

        final decimatedPoints = DataDecimator.lttbDownsample(chartPoints, 100);
        processedData = decimatedPoints
            .map(
              (point) => BiometricData(
                date: point.date!,
                hrv: point.y,
                rhr: 60, // Simplified for decimation
                steps: 5000,
                sleepScore: 75,
              ),
            )
            .toList();
      }

      // Calculate summary
      final summary = _calculateSummary(processedData, state.selectedRange);

      // Process chart data
      final hrvData = _processHrvData(processedData);
      final rhrData = _processRhrData(processedData);
      final stepsData = _processStepsData(processedData);

      // Calculate rolling stats for HRV bands
      final rollingStats = DataDecimator.calculateRollingStats(
        processedData,
        7,
      );

      emit(
        state.copyWith(
          summary: summary,
          hrvChartData: hrvData,
          rhrChartData: rhrData,
          stepsChartData: stepsData,
          rollingStats: rollingStats,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          uiState: UiState.error,
          errorMessage: 'Failed to process data: $error',
        ),
      );
    }
  }

  BiometricSummary _calculateSummary(
    List<BiometricData> data,
    DateRange range,
  ) {
    if (data.isEmpty) {
      return const BiometricSummary(
        hrvAverage: 0,
        rhrAverage: 0,
        stepsTotal: 0,
        period: '7d',
      );
    }

    final hrvAverage =
        data.map((d) => d.hrv).reduce((a, b) => a + b) / data.length;
    final rhrAverage =
        data.map((d) => d.rhr).reduce((a, b) => a + b) / data.length;
    final stepsTotal = data.map((d) => d.steps).reduce((a, b) => a + b);

    return BiometricSummary(
      hrvAverage: hrvAverage,
      rhrAverage: rhrAverage,
      stepsTotal: stepsTotal,
      period: range.label,
    );
  }

  List<ChartDataPoint> _processHrvData(List<BiometricData> data) {
    final chartData = data
        .map(
          (d) => ChartDataPoint(
            x: d.date.millisecondsSinceEpoch.toDouble(),
            y: d.hrv,
            date: d.date,
            additionalData: {'hrv': d.hrv},
          ),
        )
        .toList();

    return chartData;
  }

  List<ChartDataPoint> _processRhrData(List<BiometricData> data) {
    final chartData = data
        .map(
          (d) => ChartDataPoint(
            x: d.date.millisecondsSinceEpoch.toDouble(),
            y: d.rhr.toDouble(),
            date: d.date,
            additionalData: {'rhr': d.rhr},
          ),
        )
        .toList();

    return chartData;
  }

  List<ChartDataPoint> _processStepsData(List<BiometricData> data) {
    final chartData = data
        .map(
          (d) => ChartDataPoint(
            x: d.date.millisecondsSinceEpoch.toDouble(),
            y: d.steps.toDouble(),
            date: d.date,
            additionalData: {'steps': d.steps},
          ),
        )
        .toList();

    return chartData;
  }

  Future<void> _onCrosshairMoved(
    BiometricsDashboardCrosshairMoved event,
    Emitter<BiometricsDashboardState> emit,
  ) async {
    emit(state.copyWith(crosshairDate: event.date));
  }
}
