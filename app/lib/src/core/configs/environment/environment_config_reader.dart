class EnvironmentConfigReader {
  const EnvironmentConfigReader({required this.apiBaseUrl});

  factory EnvironmentConfigReader.fromJson(Map<String, dynamic> json) {
    return EnvironmentConfigReader(apiBaseUrl: json['apiBaseUrl'] as String);
  }

  final String apiBaseUrl;
}
