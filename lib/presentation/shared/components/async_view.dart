import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';

/// Estados de carregamento e vazio, padronizados para todas as listas.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    super.key,
    required this.isLoading,
    required this.items,
    required this.builder,
    this.emptyMessage = 'Nada por aqui ainda.',
    this.loadingHeight = 220,
  });

  final bool isLoading;
  final List<T> items;
  final Widget Function(List<T> items) builder;
  final String emptyMessage;
  final double loadingHeight;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: loadingHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) return EmptyState(message: emptyMessage);

    return builder(items);
  }
}

/// Mensagem exibida quando um filtro não devolve resultados.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          const Icon(Icons.search_off, size: 34, color: AppColors.navInactive),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
