import 'package:flutter/widgets.dart';

/// Escala de espaçamento do design.
abstract class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 28.0;
  static const double section = 40.0;

  /// Margem lateral padrão das telas (20px nas capturas de 390px).
  static const double page = 20.0;

  static const EdgeInsets pageHorizontal =
      EdgeInsets.symmetric(horizontal: page);
  static const EdgeInsets cardPadding = EdgeInsets.all(lg);

  /// Espaço reservado abaixo do conteúdo para a bottom navigation.
  static const double bottomNavClearance = 96.0;
}
