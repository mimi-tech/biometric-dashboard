import 'package:biometric_app/src/core/configs/routes/route_name.dart';
import 'package:biometric_app/src/presentation/biometrics_dashboard/view/biometrics_dashboard_page.dart';
import 'package:biometric_app/src/presentation/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver();

final GoRouter router = GoRouter(
  debugLogDiagnostics: kDebugMode || false,
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.splashRoute,
  routes: [

    GoRoute(
      name: Routes.splashRoute,
      path: Routes.splashRoute,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: SplashPage());
      },
    ),

    GoRoute(
      name: Routes.biometricsDashboardRoute,
      path: Routes.biometricsDashboardRoute,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: BiometricsDashboardPage());
      },
    ),
  ],
);
