import 'dart:math';
import 'package:biometric_app/src/domain/biometric/biometric.dart';

class DataDecimator {
  /// Largest Triangle Three Buckets (LTTB) algorithm for downsampling time series data
  static List<ChartDataPoint> lttbDownsample(
    List<ChartDataPoint> data,
    int targetSize,
  ) {
    if (data.length <= targetSize) {
      return data;
    }

    if (targetSize < 3) {
      return [data.first, data.last];
    }

    final bucketSize = (data.length - 2) / (targetSize - 2);
    final sampled = <ChartDataPoint>[data.first]; // Always include first point

    for (var i = 1; i < targetSize - 1; i++) {
      final bucketStart = (i * bucketSize).floor();
      final bucketEnd = ((i + 1) * bucketSize).floor();
      final nextBucketStart = ((i + 1) * bucketSize).floor();

      // Find point in bucket that forms largest triangle with average and next bucket average
      double maxArea = -1;
      ChartDataPoint? selectedPoint;

      for (var j = bucketStart; j < bucketEnd && j < data.length; j++) {
        final area = _calculateTriangleArea(
          sampled.last,
          data[j],
          _getAveragePoint(
            data,
            nextBucketStart,
            min(nextBucketStart + bucketSize.floor(), data.length),
          ),
        );
        if (area > maxArea) {
          maxArea = area;
          selectedPoint = data[j];
        }
      }

      if (selectedPoint != null) {
        sampled.add(selectedPoint);
      }
    }

    sampled.add(data.last); // Always include last point
    return sampled;
  }

  /// Bucket mean downsampling - simpler but less accurate than LTTB
  static List<ChartDataPoint> bucketMeanDownsample(
    List<ChartDataPoint> data,
    int targetSize,
  ) {
    if (data.length <= targetSize) {
      return data;
    }

    if (targetSize < 3) {
      return [data.first, data.last];
    }

    final bucketSize = (data.length - 2) / (targetSize - 2);
    final sampled = <ChartDataPoint>[data.first]; // Always include first point

    for (var i = 1; i < targetSize - 1; i++) {
      final start = ((i - 1) * bucketSize).floor() + 1;
      final end = (i * bucketSize).floor() + 1;
      final bucket = data.sublist(start, min(end, data.length - 1));

      if (bucket.isNotEmpty) {
        final avgX =
            bucket.map((p) => p.x).reduce((a, b) => a + b) / bucket.length;
        final avgY =
            bucket.map((p) => p.y).reduce((a, b) => a + b) / bucket.length;

        // Use the point closest to the average
        var closestPoint = bucket.first;
        var minDistance = double.infinity;

        for (final point in bucket) {
          final distance = sqrt(
            pow(point.x - avgX, 2) + pow(point.y - avgY, 2),
          );
          if (distance < minDistance) {
            minDistance = distance;
            closestPoint = point;
          }
        }

        sampled.add(closestPoint);
      }
    }

    sampled.add(data.last); // Always include last point
    return sampled;
  }

  /// Calculate rolling statistics for HRV bands
  static List<RollingStats> calculateRollingStats(
    List<BiometricData> data,
    int windowSize,
  ) {
    final stats = <RollingStats>[];

    for (var i = windowSize - 1; i < data.length; i++) {
      final window = data.sublist(i - windowSize + 1, i + 1);
      final hrvValues = window.map((d) => d.hrv).toList();

      final mean = hrvValues.reduce((a, b) => a + b) / hrvValues.length;
      final variance =
          hrvValues.map((v) => pow(v - mean, 2)).reduce((a, b) => a + b) /
          hrvValues.length;
      final stdDev = sqrt(variance);

      stats.add(
        RollingStats(
          mean: mean,
          stdDev: stdDev,
          upperBand: mean + stdDev,
          lowerBand: mean - stdDev,
        ),
      );
    }

    return stats;
  }

  static double _calculateTriangleArea(
    ChartDataPoint a,
    ChartDataPoint b,
    ChartDataPoint c,
  ) {
    return ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)).abs() / 2;
  }

  static ChartDataPoint _getAveragePoint(
    List<ChartDataPoint> data,
    int start,
    int end,
  ) {
    if (start >= end || start >= data.length) {
      return data.last;
    }

    final slice = data.sublist(start, min(end, data.length));
    final avgX = slice.map((p) => p.x).reduce((a, b) => a + b) / slice.length;
    final avgY = slice.map((p) => p.y).reduce((a, b) => a + b) / slice.length;

    return ChartDataPoint(x: avgX, y: avgY);
  }
}
