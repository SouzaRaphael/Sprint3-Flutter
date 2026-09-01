import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Botão azul em pílula — a ação principal de cada tela.
///
/// Enquanto [isLoading] estiver ativo o botão fica desabilitado e mostra um
/// indicador, o que dá retorno imediato às ações do usuário.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon = Icons.arrow_forward,
    this.showTrailingIcon = true,
    this.isLoading = false,
    this.expand = true,
    this.color = AppColors.primary,
    this.height = 56,
  });

  final String label;
  final VoidCallback? onPressed;

  /// Ícone antes do texto.
  final IconData? icon;

  /// Ícone depois do texto — por padrão a seta do design.
  final IconData trailingIcon;
  final bool showTrailingIcon;
  final bool isLoading;
  final bool expand;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;

    final button = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.pillBR,
        boxShadow: enabled ? AppColors.buttonShadow : null,
      ),
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          disabledBackgroundColor: color.withValues(alpha: 0.45),
          disabledForegroundColor: AppColors.surface,
          minimumSize: Size.fromHeight(height),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: AppColors.surface,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: AppColors.surface),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: AppTextStyles.button,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (showTrailingIcon) ...[
                    const SizedBox(width: 10),
                    Icon(trailingIcon, size: 20, color: AppColors.surface),
                  ],
                ],
              ),
      ),
    );

    return expand ? button : IntrinsicWidth(child: button);
  }
}
