import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';

/// Esfera azul difusa que fecha o hero da home pública.
///
/// Reproduzida com gradientes — o design não depende de imagem.
class HeroBlob extends StatelessWidget {
  const HeroBlob({super.key, this.height = 260});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -40,
            top: 30,
            child: _SoftGlow(
              size: height * 1.15,
              color: AppColors.accent.withValues(alpha: 0.28),
            ),
          ),
          Positioned(
            right: -30,
            top: -20,
            child: _SoftGlow(
              size: height * 0.95,
              color: AppColors.accentCyan.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            right: 30,
            top: 10,
            child: Container(
              width: height * 0.58,
              height: height * 0.58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.heroBlob,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentCyan.withValues(alpha: 0.35),
                    blurRadius: 50,
                    spreadRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Halo suave desenhado com um gradiente radial que some nas bordas.
class _SoftGlow extends StatelessWidget {
  const _SoftGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
          stops: const [0.35, 1.0],
        ),
      ),
    );
  }
}
