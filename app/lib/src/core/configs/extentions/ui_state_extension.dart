import 'package:biometric_app/src/core/enum/ui_state.dart';

extension UiStateExtensions on UiState {
  bool get isInitial => this == UiState.initial;
  bool get isLoading => this == UiState.loading;
  bool get isLoaded => this == UiState.loaded;
  bool get isError => this == UiState.error;
}
