import 'package:biometric_app/src/domain/biometric/biometric.dart';
import 'package:biometric_app/src/services/biometric/biometric_data_service.dart';

abstract class BiometricRepository {
  Future<List<BiometricData>> getBiometricData();
  Future<List<JournalEntry>> getJournalEntries();
  List<BiometricData> generateLargeDataset(int count);
}

class IBiometricRepository implements BiometricRepository {
  const IBiometricRepository({
    required BiometricDataService biometricDataService,
  }) : _biometricDataService = biometricDataService;

  final BiometricDataService _biometricDataService;

  @override
  Future<List<BiometricData>> getBiometricData() =>
      _biometricDataService.loadBiometricData();

  @override
  Future<List<JournalEntry>> getJournalEntries() =>
      _biometricDataService.loadJournalEntries();

  @override
  List<BiometricData> generateLargeDataset(int count) =>
      _biometricDataService.generateLargeDataset(count);
}
