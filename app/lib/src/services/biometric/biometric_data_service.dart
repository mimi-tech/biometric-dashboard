import 'dart:convert';
import 'dart:math';

import 'package:biometric_app/src/core/exceptions/base_exception.dart';
import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:flutter/services.dart';

abstract class BiometricDataService {
  Future<List<BiometricData>> loadBiometricData();
  Future<List<JournalEntry>> loadJournalEntries();
  List<BiometricData> generateLargeDataset(int count);
}

class IBiometricDataService implements BiometricDataService {
  static const String _biometricsAssetPath = 'assets/data/biometrics_90d.json';
  static const String _journalsAssetPath = 'assets/data/journals.json';

  // Simulate network latency and failures
  static const int _minLatencyMs = 700;
  static const int _maxLatencyMs = 1200;
  static const double _failureRate = 0.1;

  @override
  Future<List<BiometricData>> loadBiometricData() async {
    await _simulateLatency();
    await _simulateFailure();

    try {
      final jsonString = await rootBundle.loadString(_biometricsAssetPath);
      final jsonList = json.decode(jsonString) as List<dynamic>;

      return jsonList
          .map((json) => BiometricData.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      throw ServiceException(
        error: e,
        stackTrace: stackTrace,
        className: runtimeType.toString(),
        errorType: ErrorType.serviceError,
        additionalData: {'method': 'loadBiometricData'},
      );
    }
  }

  @override
  Future<List<JournalEntry>> loadJournalEntries() async {
    await _simulateLatency();
    await _simulateFailure();

    try {
      final jsonString = await rootBundle.loadString(_journalsAssetPath);
      final jsonList = json.decode(jsonString) as List<dynamic>;

      return jsonList
          .map((json) => JournalEntry.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      throw ServiceException(
        error: e,
        stackTrace: stackTrace,
        className: runtimeType.toString(),
        errorType: ErrorType.serviceError,
        additionalData: {'method': 'loadJournalEntries'},
      );
    }
  }

  @override
  List<BiometricData> generateLargeDataset(int count) {
    final random = Random();
    final now = DateTime.now();
    final data = <BiometricData>[];

    for (var i = 0; i < count; i++) {
      final date = now.subtract(Duration(days: count - i));
      data.add(
        BiometricData(
          date: date,
          hrv: 50 + random.nextDouble() * 20,
          rhr: 55 + random.nextInt(20),
          steps: 3000 + random.nextInt(8000),
          sleepScore: 60 + random.nextInt(40),
        ),
      );
    }

    return data;
  }

  Future<void> _simulateLatency() async {
    final random = Random();
    final latencyMs =
        _minLatencyMs + random.nextInt(_maxLatencyMs - _minLatencyMs);
    await Future<void>.delayed(Duration(milliseconds: latencyMs));
  }

  Future<void> _simulateFailure() async {
    final random = Random();
    if (random.nextDouble() < _failureRate) {
      throw ServiceException(
        error: 'Simulated network failure',
        className: runtimeType.toString(),
        errorType: ErrorType.networkError,
      );
    }
  }
}
