import 'package:biometric_app/l10n/arb/app_localizations.dart';
import 'package:biometric_app/src/core/configs/locator.dart';
import 'package:biometric_app/src/core/configs/routes/route_config.dart';
import 'package:biometric_app/src/core/enum/ui_state.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_bloc.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_event.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_state.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/view/biometrics_dashboard_page.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/widgets/biometrics_dashboard_shimmer.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBiometricsDashboardBloc extends MockCubit<BiometricsDashboardState>
    implements BiometricsDashboardBloc {}

void main() {
  group('BiometricsDashboardPage', () {
    late MockBiometricsDashboardBloc mockBloc;

    setUpAll(getIt.reset);

    setUp(() {
      mockBloc = MockBiometricsDashboardBloc();

      // Unregister any existing registration first
      if (getIt.isRegistered<BiometricsDashboardBloc>()) {
        getIt.unregister<BiometricsDashboardBloc>();
      }

      // Register the mock bloc for each test as lazy singleton
      getIt.registerLazySingleton<BiometricsDashboardBloc>(() => mockBloc);
    });

    tearDown(() {
      // Clean up after each test
      if (getIt.isRegistered<BiometricsDashboardBloc>()) {
        getIt.unregister<BiometricsDashboardBloc>();
      }
    });

    tearDownAll(getIt.reset);

    Widget createWidgetUnderTest() {
      return MaterialApp(
        navigatorKey: rootNavigatorKey,
        locale: const Locale('ko'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BiometricsDashboardPage(),
      );
    }

    testWidgets('should show shimmer when loading', (
      WidgetTester tester,
    ) async {
      when(
        () => mockBloc.state,
      ).thenReturn(const BiometricsDashboardState(uiState: UiState.loading));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(BiometricsDashboardShimmer), findsOneWidget);
    });

    testWidgets('should show error state when error occurs', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        const BiometricsDashboardState(
          uiState: UiState.error,
          errorMessage: 'Test error',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Test error'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should show dashboard content when loaded', (
      WidgetTester tester,
    ) async {
      final testData = [
        BiometricData(
          date: DateTime.now().subtract(const Duration(days: 1)),
          hrv: 60,
          rhr: 65,
          steps: 8000,
          sleepScore: 80,
        ),
      ];

      when(() => mockBloc.state).thenReturn(
        BiometricsDashboardState(
          uiState: UiState.loaded,
          biometricData: testData,
          summary: const BiometricSummary(
            hrvAverage: 60,
            rhrAverage: 65,
            stepsTotal: 8000,
            period: '7d',
          ),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Pump additional frames to handle chart animations
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('HRV Avg (7d)'), findsOneWidget);
      expect(find.text('RHR Avg (7d)'), findsOneWidget);
      expect(find.text('Steps Total (7d)'), findsOneWidget);
    });

    testWidgets('should show empty state when no data', (
      WidgetTester tester,
    ) async {
      when(
        () => mockBloc.state,
      ).thenReturn(const BiometricsDashboardState(uiState: UiState.loaded));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('No Data Available'), findsOneWidget);
    });

    testWidgets('should call range changed when range selector tapped', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        BiometricsDashboardState(
          uiState: UiState.loaded,
          biometricData: [
            BiometricData(
              date: DateTime.now(),
              hrv: 60,
              rhr: 65,
              steps: 8000,
              sleepScore: 80,
            ),
          ],
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Pump additional frames to handle chart animations
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.text('30d'));
      await tester.pump();

      verify(
        () => mockBloc.add(
          const BiometricsDashboardRangeChanged(DateRange.days30),
        ),
      ).called(1);
    });

    testWidgets('should call large dataset toggle when switch tapped', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        BiometricsDashboardState(
          uiState: UiState.loaded,
          biometricData: [
            BiometricData(
              date: DateTime.now(),
              hrv: 60,
              rhr: 65,
              steps: 8000,
              sleepScore: 80,
            ),
          ],
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Pump additional frames to handle chart animations
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.byType(Switch));
      await tester.pump();

      verify(
        () => mockBloc.add(
          const BiometricsDashboardLargeDatasetToggled(enabled: true),
        ),
      ).called(1);
    });

    testWidgets('should call retry when retry button tapped', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        const BiometricsDashboardState(
          uiState: UiState.error,
          errorMessage: 'Test error',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(
        () => mockBloc.add(const BiometricsDashboardRetryPressed()),
      ).called(1);
    });
  });
}
