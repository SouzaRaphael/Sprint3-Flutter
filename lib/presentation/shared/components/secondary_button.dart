import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Botão branco com borda — a ação alternativa ao lado da principal.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.expand = true,
    this.height = 56,
    this.foregroundColor = AppColors.primaryDark,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool expand;
  final double height;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(height),
        foregroundColor: foregroundColor,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.pillBR),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: foregroundColor),
            const SizedBox(width: 10),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.button.copyWith(color: foregroundColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 10),
            Icon(trailingIcon, size: 20, color: foregroundColor),
          ],
        ],
      ),
    );

    return expand ? button : IntrinsicWidth(child: button);
  }
}
