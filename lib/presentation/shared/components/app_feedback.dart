import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Retorno visual padronizado após as ações do usuário.
///
/// Centralizar aqui garante que confirmar uma coleta, publicar um depoimento
/// ou falhar no login sempre respondam com o mesmo vocabulário visual.
abstract class AppFeedback {
  static void success(BuildContext context, String message) =>
      _show(context, message, Icons.check_circle, AppColors.successFg);

  static void info(BuildContext context, String message) =>
      _show(context, message, Icons.info, AppColors.accent);

  static void error(BuildContext context, String message) => _show(
    context,
    message,
    Icons.error,
    Theme.of(context).colorScheme.error,
  );

  static void _show(
    BuildContext context,
    String message,
    IconData icon,
    Color accent,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              Icon(icon, color: accent, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
