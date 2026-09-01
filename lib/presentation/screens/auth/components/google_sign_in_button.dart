import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Botão "Entrar com Google" — nesta Sprint apenas simula o acesso social.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _GoogleGlyph(),
          const SizedBox(width: 12),
          Text(
            'Entrar com Google',
            style: AppTextStyles.button.copyWith(color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}

/// "G" nas quatro cores da marca, desenhado sem depender de asset.
class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      height: 22,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF4285F4),
                  Color(0xFF34A853),
                  Color(0xFFFBBC05),
                  Color(0xFFEA4335),
                  Color(0xFF4285F4),
                ],
              ),
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
          const Positioned(
            right: 0,
            child: SizedBox(
              width: 11,
              height: 5,
              child: ColoredBox(color: Color(0xFF4285F4)),
            ),
          ),
        ],
      ),
    );
  }
}
