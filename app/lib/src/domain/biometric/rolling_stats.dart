import 'package:equatable/equatable.dart';

class RollingStats extends Equatable {
  const RollingStats({
    required this.mean,
    required this.stdDev,
    required this.upperBand,
    required this.lowerBand,
  });

  final double mean;
  final double stdDev;
  final double upperBand;
  final double lowerBand;

  @override
  List<Object?> get props => [mean, stdDev, upperBand, lowerBand];
}
