import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';

/// Mapa ilustrado desenhado à mão.
///
/// O protótipo mostra um mapa estilizado, sem fotografia de satélite. Como
/// esta Sprint não integra SDK de mapas, o traçado é reproduzido com
/// [CustomPainter] — sem chave de API e sem acesso à rede.
class MapCanvas extends StatelessWidget {
  const MapCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: CustomPaint(painter: _MapPainter()),
    );
  }
}

class _MapPainter extends CustomPainter {
  const _MapPainter();

  /// Vias horizontais e verticais, em fração da largura/altura.
  static const List<double> _verticalRoads = [0.18, 0.46, 0.74];
  static const List<double> _horizontalRoads = [0.26, 0.55, 0.82];

  /// Manchas de vegetação: centro x, centro y e raio, em fração.
  static const List<(double, double, double)> _parks = [
    (0.14, 0.18, 0.16),
    (0.82, 0.14, 0.13),
    (0.30, 0.72, 0.18),
    (0.88, 0.66, 0.15),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFE8EFF5);
    canvas.drawRect(Offset.zero & size, background);

    final park = Paint()..color = const Color(0xFFDCE9DE);
    for (final (x, y, radius) in _parks) {
      canvas.drawCircle(
        Offset(size.width * x, size.height * y),
        size.width * radius,
        park,
      );
    }

    final water = Paint()..color = const Color(0xFFD6E6F2);
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.36),
      size.width * 0.22,
      water,
    );

    // Quarteirões: uma grade fina por trás das avenidas.
    final block = Paint()
      ..color = const Color(0xFFCBD8E4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 1; i < 6; i++) {
      final dx = size.width * i / 6;
      final dy = size.height * i / 6;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), block);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), block);
    }

    // Avenidas principais, em branco e mais largas.
    final road = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;
    for (final x in _verticalRoads) {
      canvas.drawLine(
        Offset(size.width * x, -10),
        Offset(size.width * x, size.height + 10),
        road,
      );
    }
    for (final y in _horizontalRoads) {
      canvas.drawLine(
        Offset(-10, size.height * y),
        Offset(size.width + 10, size.height * y),
        road,
      );
    }

    // Avenida diagonal, que quebra a rigidez da grade.
    canvas.drawLine(
      Offset(-10, size.height * 0.92),
      Offset(size.width + 10, size.height * 0.08),
      road..strokeWidth = 10,
    );
  }

  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) => false;
}

/// Marcador de gota usado para cada ponto da rede.
class MapPin extends StatelessWidget {
  const MapPin({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.size = 34,
  });

  final bool isSelected;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.18 : 1,
        duration: const Duration(milliseconds: 180),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accent : AppColors.primary,
                borderRadius: BorderRadius.circular(size * 0.45),
                border: Border.all(color: AppColors.surface, width: 2.5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33101828),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.water_drop,
                size: size * 0.46,
                color: AppColors.surface,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -3),
              child: CustomPaint(
                size: const Size(12, 8),
                painter: _PinTailPainter(
                  color: isSelected ? AppColors.accent : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PinTailPainter extends CustomPainter {
  const _PinTailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _PinTailPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Indicador da posição atual da doadora.
class CurrentLocationDot extends StatelessWidget {
  const CurrentLocationDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.28),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.surface, width: 2.5),
        ),
      ),
    );
  }
}
