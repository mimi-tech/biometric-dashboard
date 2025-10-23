import 'package:flutter/material.dart';

class AppShadows {
  static BoxShadow depth1 = BoxShadow(
    color: Colors.black.withValues(alpha: 0.05),
    offset: const Offset(0, 2),
    blurRadius: 8,
  );
  static BoxShadow depth2 = BoxShadow(
    color: Colors.black.withValues(alpha: 0.08),
    offset: const Offset(0, 2),
    blurRadius: 6,
  );
}
