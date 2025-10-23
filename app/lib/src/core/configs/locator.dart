import 'package:biometric_app/src/presentation/biometrics_dashboard/bloc/biometrics_dashboard_bloc.dart';
import 'package:biometric_app/src/repositories/biometric/biometric_repository.dart';
import 'package:biometric_app/src/services/biometric/biometric_data_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // ✅ Services
  getIt
    ..registerLazySingleton<BiometricDataService>(IBiometricDataService.new)
    // ✅ Repositories
    ..registerLazySingleton<IBiometricRepository>(
      () => IBiometricRepository(
        biometricDataService: getIt<BiometricDataService>(),
      ),
    )
    // ✅ Blocs
    ..registerLazySingleton<BiometricsDashboardBloc>(
      () => BiometricsDashboardBloc(
        biometricRepository: getIt<IBiometricRepository>(),
      ),
    );
}
