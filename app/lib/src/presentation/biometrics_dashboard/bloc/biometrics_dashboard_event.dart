import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:equatable/equatable.dart';

abstract class BiometricsDashboardEvent extends Equatable {
  const BiometricsDashboardEvent();

  @override
  List<Object?> get props => [];
}

class BiometricsDashboardInitialized extends BiometricsDashboardEvent {
  const BiometricsDashboardInitialized();
}

class BiometricsDashboardRangeChanged extends BiometricsDashboardEvent {
  const BiometricsDashboardRangeChanged(this.range);

  final DateRange range;

  @override
  List<Object?> get props => [range];
}

class BiometricsDashboardLargeDatasetToggled extends BiometricsDashboardEvent {
  const BiometricsDashboardLargeDatasetToggled({required this.enabled});

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}

class BiometricsDashboardRetryPressed extends BiometricsDashboardEvent {
  const BiometricsDashboardRetryPressed();
}

class BiometricsDashboardCrosshairMoved extends BiometricsDashboardEvent {
  const BiometricsDashboardCrosshairMoved(this.date);

  final DateTime? date;

  @override
  List<Object?> get props => [date];
}
