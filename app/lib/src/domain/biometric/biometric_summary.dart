import 'package:equatable/equatable.dart';

class BiometricSummary extends Equatable {
  const BiometricSummary({
    required this.hrvAverage,
    required this.rhrAverage,
    required this.stepsTotal,
    required this.period,
  });

  final double hrvAverage;
  final double rhrAverage;
  final int stepsTotal;
  final String period;

  @override
  List<Object?> get props => [hrvAverage, rhrAverage, stepsTotal, period];
}
