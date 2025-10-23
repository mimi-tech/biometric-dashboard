import 'package:app_ui/app_theme.dart';
import 'package:biometric_app/src/core/configs/routes/route_name.dart';
import 'package:biometric_app/src/core/const/assets/gif_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToDashboard();
  }

  void _navigateToDashboard() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(Routes.biometricsDashboardRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          GifAssets.loading,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to success icon if GIF fails to load
            return const Icon(
              Icons.check_circle,
              color: AppSemanticColors.feedbackSuccess,
              size: 80,
            );
          },
        ),
      ),
    );
  }
}
