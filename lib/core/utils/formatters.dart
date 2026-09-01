/// Formatações de exibição usadas em mais de uma tela.
abstract class Formatters {
  static const List<String> _months = [
    'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
    'jul', 'ago', 'set', 'out', 'nov', 'dez',
  ];

  static const List<String> _weekdays = [
    'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom',
  ];

  /// `460` → `460 ml`.
  static String volume(int milliliters) => '$milliliters ml';

  /// `3200` → `3,2 L`.
  static String liters(int milliliters) {
    final value = milliliters / 1000;
    return '${value.toStringAsFixed(1).replaceAll('.', ',')} L';
  }

  /// `1284` → `1.284`.
  static String thousands(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// `DateTime(2026, 5, 8)` → `8 mai`.
  static String shortDate(DateTime date) =>
      '${date.day} ${_months[date.month - 1]}';

  /// `DateTime(2026, 5, 8)` → `08/mai`.
  static String paddedDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${_months[date.month - 1]}';

  /// Abreviação do mês em maiúsculas, usada no selo de data.
  static String monthBadge(DateTime date) =>
      _months[date.month - 1].toUpperCase();

  /// `DateTime(2026, 5, 8)` → `Sex, 8 mai`.
  static String weekdayAndDate(DateTime date) =>
      '${_weekdays[date.weekday - 1]}, ${shortDate(date)}';

  /// Diferença em dias a partir de [reference], em linguagem natural.
  static String daysUntil(DateTime date, DateTime reference) {
    final days = DateTime(date.year, date.month, date.day)
        .difference(DateTime(reference.year, reference.month, reference.day))
        .inDays;
    if (days < 0) return 'já passou';
    if (days == 0) return 'hoje';
    if (days == 1) return 'amanhã';
    return 'em $days dias';
  }

  /// `3` → `3 dias atrás`. Usado no resumo da jornada.
  static String daysAgo(int days) {
    if (days == 0) return 'hoje';
    if (days == 1) return 'ontem';
    return '$days dias atrás';
  }

  /// Iniciais para os avatares em gradiente.
  static String initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}
