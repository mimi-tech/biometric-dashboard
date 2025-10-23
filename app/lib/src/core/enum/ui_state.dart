enum UiState { loading, loaded, error, initial }

extension UiStateExtension on UiState {
  bool get isLoading => this == UiState.loading;
  bool get isLoaded => this == UiState.loaded;
  bool get isError => this == UiState.error;
  bool get isInitial => this == UiState.initial;
}
