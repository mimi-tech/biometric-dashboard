import 'package:equatable/equatable.dart';

class ChartDataPoint extends Equatable {
  const ChartDataPoint({
    required this.x,
    required this.y,
    this.date,
    this.additionalData,
  });

  final double x;
  final double y;
  final DateTime? date;
  final Map<String, dynamic>? additionalData;

  @override
  List<Object?> get props => [x, y, date, additionalData];
}
