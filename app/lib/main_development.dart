import 'package:biometric_app/app.dart';
import 'package:biometric_app/bootstrap.dart';
import 'package:biometric_app/src/core/configs/app_config.dart';
import 'package:biometric_app/src/core/configs/environment/environment.dart';

Future<void> main() async {
  await AppConfig().appInitSetup(Environment.development);
  await bootstrap(() => const App());
}
