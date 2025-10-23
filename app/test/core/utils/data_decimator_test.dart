import 'dart:math';

import 'package:biometric_app/src/core/utils/data_decimator.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DataDecimator', () {
    late List<ChartDataPoint> testData;

    setUp(() {
      testData = List.generate(100, (index) {
        return ChartDataPoint(
          x: index.toDouble(),
          y: 50 + (index % 20).toDouble(),
          date: DateTime.now().subtract(Duration(days: 100 - index)),
        );
      });
    });

    group('LTTB Downsampling', () {
      test('should preserve first and last points', () {
        final result = DataDecimator.lttbDownsample(testData, 10);

        expect(result.first.x, equals(testData.first.x));
        expect(result.first.y, equals(testData.first.y));
        expect(result.last.x, equals(testData.last.x));
        expect(result.last.y, equals(testData.last.y));
      });

      test('should return original data when target size is larger', () {
        final result = DataDecimator.lttbDownsample(testData, 200);

        expect(result.length, equals(testData.length));
        expect(result, equals(testData));
      });

      test('should reduce data size correctly', () {
        final result = DataDecimator.lttbDownsample(testData, 20);

        expect(result.length, equals(20));
        expect(result.length, lessThan(testData.length));
      });

      test('should preserve min/max values approximately', () {
        final minY = testData.map((p) => p.y).reduce((a, b) => a < b ? a : b);
        final maxY = testData.map((p) => p.y).reduce((a, b) => a > b ? a : b);

        final result = DataDecimator.lttbDownsample(testData, 10);
        final resultMinY = result
            .map((p) => p.y)
            .reduce((a, b) => a < b ? a : b);
        final resultMaxY = result
            .map((p) => p.y)
            .reduce((a, b) => a > b ? a : b);

        expect(
          resultMinY,
          lessThanOrEqualTo(minY + 1),
        ); // Allow small tolerance
        expect(
          resultMaxY,
          greaterThanOrEqualTo(maxY - 1),
        ); // Allow small tolerance
      });

      test('should handle edge cases', () {
        // Empty data
        expect(DataDecimator.lttbDownsample([], 10), isEmpty);

        // Single point
        final singlePoint = [const ChartDataPoint(x: 0, y: 0)];
        final result = DataDecimator.lttbDownsample(singlePoint, 10);
        expect(result.length, equals(1));
        expect(result.first, equals(singlePoint.first));

        // Two points
        final twoPoints = [
          const ChartDataPoint(x: 0, y: 0),
          const ChartDataPoint(x: 1, y: 1),
        ];
        final result2 = DataDecimator.lttbDownsample(twoPoints, 10);
        expect(result2.length, equals(2));
        expect(result2, equals(twoPoints));
      });
    });

    group('Bucket Mean Downsampling', () {
      test('should preserve first and last points', () {
        final result = DataDecimator.bucketMeanDownsample(testData, 10);

        expect(result.first.x, equals(testData.first.x));
        expect(result.first.y, equals(testData.first.y));
        expect(result.last.x, equals(testData.last.x));
        expect(result.last.y, equals(testData.last.y));
      });

      test('should return original data when target size is larger', () {
        final result = DataDecimator.bucketMeanDownsample(testData, 200);

        expect(result.length, equals(testData.length));
        expect(result, equals(testData));
      });

      test('should reduce data size correctly', () {
        final result = DataDecimator.bucketMeanDownsample(testData, 20);

        expect(result.length, equals(20));
        expect(result.length, lessThan(testData.length));
      });

      test('should handle edge cases', () {
        // Empty data
        expect(DataDecimator.bucketMeanDownsample([], 10), isEmpty);

        // Single point
        final singlePoint = [const ChartDataPoint(x: 0, y: 0)];
        final result = DataDecimator.bucketMeanDownsample(singlePoint, 10);
        expect(result.length, equals(1));
        expect(result.first, equals(singlePoint.first));
      });
    });

    group('Rolling Statistics', () {
      late List<BiometricData> biometricData;

      setUp(() {
        biometricData = List.generate(20, (index) {
          return BiometricData(
            date: DateTime.now().subtract(Duration(days: 20 - index)),
            hrv: 50 + (index % 20).toDouble(),
            rhr: 60 + (index % 10),
            steps: 5000 + (index * 100),
            sleepScore: 70 + (index % 30),
          );
        });
      });

      test('should calculate correct rolling statistics', () {
        final stats = DataDecimator.calculateRollingStats(biometricData, 7);

        expect(stats.length, equals(14)); // 20 - 7 + 1

        // Check first rolling window
        final firstWindow = biometricData.sublist(0, 7);
        final expectedMean =
            firstWindow.map((d) => d.hrv).reduce((a, b) => a + b) / 7;
        final expectedVariance =
            firstWindow
                .map((d) => (d.hrv - expectedMean) * (d.hrv - expectedMean))
                .reduce((a, b) => a + b) /
            7;
        final expectedStdDev = sqrt(expectedVariance);

        expect(stats.first.mean, closeTo(expectedMean, 0.01));
        expect(stats.first.stdDev, closeTo(expectedStdDev, 0.01));
        expect(
          stats.first.upperBand,
          closeTo(expectedMean + expectedStdDev, 0.01),
        );
        expect(
          stats.first.lowerBand,
          closeTo(expectedMean - expectedStdDev, 0.01),
        );
      });

      test('should handle window size larger than data', () {
        final stats = DataDecimator.calculateRollingStats(biometricData, 25);

        expect(stats, isEmpty);
      });

      test('should handle empty data', () {
        final stats = DataDecimator.calculateRollingStats([], 7);

        expect(stats, isEmpty);
      });

      test('should handle window size of 1', () {
        final stats = DataDecimator.calculateRollingStats(biometricData, 1);

        expect(stats.length, equals(biometricData.length));

        for (var i = 0; i < stats.length; i++) {
          expect(stats[i].mean, equals(biometricData[i].hrv));
          expect(stats[i].stdDev, equals(0.0));
          expect(stats[i].upperBand, equals(biometricData[i].hrv));
          expect(stats[i].lowerBand, equals(biometricData[i].hrv));
        }
      });
    });
  });
}
