import 'package:biometric_app/l10n/arb/app_localizations.dart';
import 'package:biometric_app/src/core/configs/routes/route_config.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', 'US'),
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: LoaderOverlay(
            //overlayColor: AppPrimitiveColors.bAlpha40,
            overlayWidgetBuilder: (progress) {
              return const Center(
                child: CircularProgressIndicator(
                  //color: AppSemanticColors.prPrimary,
                ),
              );
            },
            child: SafeArea(top: false, child: child!),
          ),
        );
      },
    );
  }
}
