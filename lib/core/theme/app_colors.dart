import 'package:flutter/material.dart';

/// Paleta do Lactare, extraída diretamente das telas de referência
/// em `docs/Lactare-Telas.pdf`.
abstract class AppColors {
  // ── Azuis da marca ───────────────────────────────────────────
  static const Color primary = Color(0xFF00458B);
  static const Color primaryDark = Color(0xFF002A55);
  static const Color primaryDeep = Color(0xFF133E95);
  static const Color accent = Color(0xFF54B2E3);
  static const Color accentCyan = Color(0xFF0DA4DF);

  // ── Neutros ──────────────────────────────────────────────────
  static const Color ink = Color(0xFF101828);
  static const Color inkMuted = Color(0xFF4A5565);
  static const Color navInactive = Color(0xFF5A6B80);
  static const Color bgLanding = Color(0xFFF9FAFB);
  static const Color bgApp = Color(0xFFF7FBFD);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE1E6F0);
  static const Color borderInput = Color(0xFFE3EDF5);
  static const Color tintBlue = Color(0xFFEAF6FC);

  // ── Status ───────────────────────────────────────────────────
  static const Color successBg = Color(0xFFD8F7F5);
  static const Color successFg = Color(0xFF1B7F79);
  static const Color pinkBg = Color(0xFFFDE6EF);
  static const Color pinkFg = Color(0xFFB53272);
  static const Color pinkStrong = Color(0xFFF25CA2);
  static const Color warningBg = Color(0xFFFDF0DC);
  static const Color warningFg = Color(0xFF9A6412);

  // ── Capas coloridas dos conteúdos ────────────────────────────
  static const Color coverBlue = Color(0xFFB6E0F4);
  static const Color coverLilac = Color(0xFFEDD3F5);
  static const Color coverMint = Color(0xFF9BEFE9);
  static const Color coverPeach = Color(0xFFF9D9B8);
  static const Color coverRose = Color(0xFFFCE4EC);

  // ── Gradientes ───────────────────────────────────────────────
  /// Cards "Próxima coleta" e "Sua jornada".
  static const LinearGradient heroCard = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF054C93), Color(0xFF3185C8)],
  );

  /// Blob decorativo do topo da landing.
  static const RadialGradient heroBlob = RadialGradient(
    center: Alignment(-0.3, -0.4),
    radius: 0.9,
    colors: [Color(0xFFBEE9FF), Color(0xFF2AB1F0), Color(0xFF0E8FD8)],
    stops: [0.0, 0.55, 1.0],
  );

  /// Sombra padrão dos cards claros.
  static List<BoxShadow> get cardShadow => const [
    BoxShadow(
      color: Color(0x0F0F2A4A),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
  ];

  /// Sombra mais presente, usada nos botões primários.
  static List<BoxShadow> get buttonShadow => const [
    BoxShadow(
      color: Color(0x2600458B),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  /// Gradientes usados nos avatares das doadoras e nas conquistas.
  static const List<List<Color>> avatarGradients = [
    [Color(0xFFF7A8C4), Color(0xFFD98BC7)],
    [Color(0xFF56D6C6), Color(0xFF2FB5B0)],
    [Color(0xFFF9A26C), Color(0xFFF2704B)],
    [Color(0xFF6BA8E8), Color(0xFF3C6FD1)],
    [Color(0xFF9BE7DF), Color(0xFF63C6D6)],
    [Color(0xFFC9A7F0), Color(0xFF9B6FE0)],
  ];
}
