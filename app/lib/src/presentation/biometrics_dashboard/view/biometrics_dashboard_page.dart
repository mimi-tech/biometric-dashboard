import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:biometric_app/src/core/configs/locator.dart';
import 'package:biometric_app/src/core/enum/ui_state.dart';
import 'package:biometric_app/src/core/utils/device_utils.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_bloc.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_event.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_state.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/biometric_summary_cards.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/biometrics_dashboard_shimmer.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/biometrics_empty_state.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/biometrics_error_state.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/dashboard_side_menu.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/large_dataset_toggle.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/range_selector.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/synchronized_charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricsDashboardPage extends StatefulWidget {
  const BiometricsDashboardPage({super.key});

  @override
  State<BiometricsDashboardPage> createState() =>
      _BiometricsDashboardPageState();
}

class _BiometricsDashboardPageState extends State<BiometricsDashboardPage> {
  late final BiometricsDashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    _dashboardBloc = getIt<BiometricsDashboardBloc>();
    _dashboardBloc.add(const BiometricsDashboardInitialized());
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<BiometricsDashboardBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppSemanticColors.bgInverse,
      body: Row(
        children: [
          if (!DeviceUtils.isMobile(context)) ...[const DashboardSideMenu()],

          Expanded(
            child: Column(
              children: [
                CustomAppBar.sub(
                  title: context.l10n.biometricsDashboardTitle,

                  backgroundColor: AppSemanticColors.bgInverse,
                ),
                Expanded(
                  child:
                      BlocBuilder<
                        BiometricsDashboardBloc,
                        BiometricsDashboardState
                      >(
                        bloc: _dashboardBloc,
                        builder: (context, state) {
                          if (state.uiState.isLoading) {
                            return const BiometricsDashboardShimmer();
                          }

                          if (state.uiState.isError) {
                            return BiometricsErrorState(
                              errorMessage:
                                  state.errorMessage ?? context.l10n.anErrorOccurred,
                              onRetry: () => _dashboardBloc.add(
                                const BiometricsDashboardRetryPressed(),
                              ),
                            );
                          }

                          if (state.uiState.isLoaded &&
                              state.biometricData.isEmpty) {
                            return const BiometricsEmptyState();
                          }

                          return SingleChildScrollView(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Summary Cards
                                BiometricSummaryCards(summary: state.summary),
                                const SizedBox(height: 24),

                                // Controls
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: RangeSelector(
                                        selectedRange: state.selectedRange,
                                        onRangeChanged: (range) =>
                                            _dashboardBloc.add(
                                              BiometricsDashboardRangeChanged(
                                                range,
                                              ),
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    LargeDatasetToggle(
                                      enabled: state.largeDatasetEnabled,
                                      onChanged: (enabled) {
                                        _dashboardBloc.add(
                                          BiometricsDashboardLargeDatasetToggled(
                                            enabled: enabled,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                SynchronizedCharts(
                                  hrvData: state.hrvChartData,
                                  rhrData: state.rhrChartData,
                                  stepsData: state.stepsChartData,
                                  rollingStats: state.rollingStats,
                                  journalEntries: state.journalEntries,
                                  crosshairDate: state.crosshairDate,
                                  onCrosshairMoved: (date) {
                                    _dashboardBloc.add(
                                      BiometricsDashboardCrosshairMoved(date),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
