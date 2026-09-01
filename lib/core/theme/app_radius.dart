import 'package:flutter/widgets.dart';

/// Raios de borda do design.
abstract class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double pill = 100.0;

  static const BorderRadius cardBR = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius largeCardBR =
      BorderRadius.all(Radius.circular(xl));
  static const BorderRadius inputBR = BorderRadius.all(Radius.circular(md));
  static const BorderRadius pillBR = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius sheetBR =
      BorderRadius.vertical(top: Radius.circular(xxl));
}
