import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/l10n/l10n.dart';
import 'package:biometric_app/src/core/utils/device_utils.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BaseChartWidget extends StatelessWidget {
  const BaseChartWidget({
    required this.title,
    required this.yAxisTitle,
    required this.child,
    super.key,
  });

  final String title;
  final String yAxisTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(AppPadding.xxl),
      decoration: BoxDecoration(
        color: AppPrimitiveColors.gray800,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.h4.fontIconQuaternary),
          const SizedBox(height: AppPadding.xxl),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Common axis configuration for all charts
class CommonAxisConfig {
  static DateTimeAxis get primaryXAxis => DateTimeAxis(
    majorGridLines: const MajorGridLines(
      color: AppSemanticColors.borderQuaternary,
    ),
    minorGridLines: const MinorGridLines(
      color: AppSemanticColors.borderTertiary,
    ),
    axisLine: const AxisLine(color: AppSemanticColors.borderQuaternary),
    labelStyle: AppTextStyle.text3.fontIconTertiary,
    majorTickLines: const MajorTickLines(
      color: AppSemanticColors.borderQuaternary,
    ),
    minorTickLines: const MinorTickLines(
      color: AppSemanticColors.borderTertiary,
    ),
    dateFormat: DateFormat.MMMd(),
  );

  static NumericAxis primaryYAxis(String title) => NumericAxis(
    title: AxisTitle(
      text: title,
      textStyle: AppTextStyle.text3.fontIconTertiary,
    ),
    majorGridLines: const MajorGridLines(
      color: AppSemanticColors.borderQuaternary,
    ),
    minorGridLines: const MinorGridLines(
      color: AppSemanticColors.borderTertiary,
    ),
    axisLine: const AxisLine(color: AppSemanticColors.borderQuaternary),
    labelStyle: AppTextStyle.text3.fontIconTertiary,
    majorTickLines: const MajorTickLines(
      color: AppSemanticColors.borderQuaternary,
    ),
    minorTickLines: const MinorTickLines(
      color: AppSemanticColors.borderTertiary,
    ),
  );

  static TooltipBehavior get tooltipBehavior => TooltipBehavior(
    enable: true,
    color: AppSemanticColors.bgInteractiveTertiary,
    textStyle: AppTextStyle.text3.fontIconInverse,
  );
}

class SynchronizedCharts extends StatefulWidget {
  const SynchronizedCharts({
    required this.hrvData,
    required this.rhrData,
    required this.stepsData,
    required this.rollingStats,
    required this.journalEntries,
    required this.crosshairDate,
    required this.onCrosshairMoved,
    super.key,
  });

  final List<ChartDataPoint> hrvData;
  final List<ChartDataPoint> rhrData;
  final List<ChartDataPoint> stepsData;
  final List<RollingStats> rollingStats;
  final List<JournalEntry> journalEntries;
  final DateTime? crosshairDate;
  final ValueChanged<DateTime?> onCrosshairMoved;

  @override
  State<SynchronizedCharts> createState() => _SynchronizedChartsState();
}

class _SynchronizedChartsState extends State<SynchronizedCharts> {
  ZoomPanBehavior? _zoomPanBehavior;
  ZoomPanBehavior? _hrvZoomPanBehavior;
  ZoomPanBehavior? _rhrZoomPanBehavior;
  CrosshairBehavior? _hrvCrosshairBehavior;
  CrosshairBehavior? _rhrCrosshairBehavior;
  CrosshairBehavior? _stepsCrosshairBehavior;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
    );

    _hrvZoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
    );

    _rhrZoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
    );

    _hrvCrosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineColor: AppPrimitiveColors.gold500,
      lineWidth: 2,
      lineDashArray: const [5, 5],
    );

    _rhrCrosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineColor: Colors.white,
      lineWidth: 2,
      lineDashArray: const [5, 5],
    );

    _stepsCrosshairBehavior = CrosshairBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      lineColor: Colors.white,
      lineWidth: 2,
      lineDashArray: const [5, 5],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (DeviceUtils.isDesktop(context)) ...[
          Row(
            children: [
              Expanded(child: _buildHrvChart()),
              const SizedBox(width: 10),
              Expanded(child: _buildRhrChart()),
            ],
          ),
        ] else
          Wrap(
            spacing: 10,
            children: [
              _buildHrvChart(),
              const SizedBox(width: 10),
              _buildRhrChart(),
            ],
          ),

        const SizedBox(height: 24),
        _buildStepsChart(),
      ],
    );
  }

  Widget _buildHrvChart() {
    return BaseChartWidget(
      title: context.l10n.hrv,
      yAxisTitle: context.l10n.hrvMs,
      child: SfCartesianChart(
        zoomPanBehavior: _hrvZoomPanBehavior,
        crosshairBehavior: _hrvCrosshairBehavior,
        primaryXAxis: CommonAxisConfig.primaryXAxis,
        primaryYAxis: CommonAxisConfig.primaryYAxis(context.l10n.hrvMs),
        series: <CartesianSeries<ChartDataPoint, DateTime>>[
          AreaSeries<ChartDataPoint, DateTime>(
            dataSource: widget.hrvData,
            xValueMapper: (ChartDataPoint data, _) => data.date,
            yValueMapper: (ChartDataPoint data, _) => data.y,
            color: AppSemanticColors.tePrimary.withValues(alpha: 0.1),
            borderColor: AppSemanticColors.tePrimary,
            name: context.l10n.hrv,
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: AppSemanticColors.bgInteractiveTertiary,
          textStyle: AppTextStyle.text3.fontIconInverse,
          builder: (data, point, series, pointIndex, seriesIndex) {
            final chartData = data as ChartDataPoint;
            final mean =
                widget.rollingStats.isNotEmpty &&
                    pointIndex < widget.rollingStats.length
                ? widget.rollingStats[pointIndex].mean
                : 0;
            final stdDev =
                widget.rollingStats.isNotEmpty &&
                    pointIndex < widget.rollingStats.length
                ? widget.rollingStats[pointIndex].stdDev
                : 0;

            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppSemanticColors.bgInverse,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                context.l10n.hrvTooltip(
                  DateFormat.MMMd().format(chartData.date!),
                  chartData.y.toStringAsFixed(1),
                  mean.toStringAsFixed(1),
                  stdDev.toStringAsFixed(1),
                ),
                style: AppTextStyle.p4.fontIconInverse,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRhrChart() {
    return BaseChartWidget(
      title: context.l10n.rhr,
      yAxisTitle: context.l10n.rhrBpm,
      child: SfCartesianChart(
        zoomPanBehavior: _rhrZoomPanBehavior,
        crosshairBehavior: _rhrCrosshairBehavior,
        primaryXAxis: CommonAxisConfig.primaryXAxis,
        primaryYAxis: CommonAxisConfig.primaryYAxis(context.l10n.rhrBpm),
        series: <CartesianSeries<ChartDataPoint, DateTime>>[
          LineSeries<ChartDataPoint, DateTime>(
            dataSource: widget.rhrData,
            xValueMapper: (ChartDataPoint data, _) => data.date,
            yValueMapper: (ChartDataPoint data, _) => data.y,
            color: AppPrimitiveColors.purple500,
            name: context.l10n.rhr,
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: AppSemanticColors.bgInteractiveTertiary,
          textStyle: AppTextStyle.text3.fontIconInverse,
          builder: (data, point, series, pointIndex, seriesIndex) {
            final chartData = data as ChartDataPoint;
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppSemanticColors.bgInverse,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                context.l10n.rhrTooltip(
                  DateFormat.MMMd().format(chartData.date!),
                  chartData.y.toStringAsFixed(0),
                ),
                style: AppTextStyle.p4.fontIconInverse,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepsChart() {
    return BaseChartWidget(
      title: context.l10n.steps,
      yAxisTitle: context.l10n.steps,
      child: SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        crosshairBehavior: _stepsCrosshairBehavior,
        primaryXAxis: CommonAxisConfig.primaryXAxis,
        primaryYAxis: CommonAxisConfig.primaryYAxis(context.l10n.steps),
        series: <CartesianSeries<ChartDataPoint, DateTime>>[
          AreaSeries<ChartDataPoint, DateTime>(
            dataSource: widget.stepsData,
            xValueMapper: (ChartDataPoint data, _) => data.date,
            yValueMapper: (ChartDataPoint data, _) => data.y,
            color: AppSemanticColors.feedbackWarning.withValues(alpha: 0.3),
            borderColor: AppSemanticColors.feedbackWarning,
            name: context.l10n.steps,
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: AppSemanticColors.bgInteractiveTertiary,
          textStyle: AppTextStyle.text3.fontIconInverse,
          builder: (data, point, series, pointIndex, seriesIndex) {
            final chartData = data as ChartDataPoint;
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppSemanticColors.bgInverse,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                context.l10n.stepsTooltip(
                  DateFormat.MMMd().format(chartData.date!),
                  chartData.y.toStringAsFixed(0),
                ),
                style: AppTextStyle.p4.fontIconInverse,
              ),
            );
          },
        ),
      ),
    );
  }
}
