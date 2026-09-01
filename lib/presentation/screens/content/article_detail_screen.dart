import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Leitura de um artigo.
///
/// Recebe o [Article] por `settings.arguments`, vindo da lista de conteúdo
/// ou dos carrosséis de leitura.
class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
    required this.goBack,
  });

  final Article article;
  final VoidCallback goBack;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  bool _isSaved = false;

  void _toggleSaved() {
    setState(() => _isSaved = !_isSaved);
    AppFeedback.success(
      context,
      _isSaved
          ? 'Artigo salvo na sua lista de leitura.'
          : 'Artigo removido da sua lista.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              title: article.category.label,
              onBack: widget.goBack,
              trailing: IconButton(
                onPressed: _toggleSaved,
                tooltip: _isSaved ? 'Remover da lista' : 'Salvar para ler',
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: AppColors.primary,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(height: 170, color: article.coverColor),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      AppSpacing.xl,
                      AppSpacing.page,
                      AppSpacing.section,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatusBadge(
                          label: article.readingLabel,
                          background: AppColors.tintBlue,
                          foreground: AppColors.primary,
                          icon: Icons.schedule,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          article.title,
                          style: AppTextStyles.heroTitle.copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(article.summary, style: AppTextStyles.body),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 16,
                              color: AppColors.navInactive,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                article.author,
                                style: AppTextStyles.caption,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        const Divider(),
                        const SizedBox(height: AppSpacing.xl),
                        for (final paragraph in article.paragraphs) ...[
                          Text(
                            paragraph,
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.ink,
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: AppColors.tintBlue,
                            borderRadius: AppRadius.cardBR,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.support_agent_outlined,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  'Ficou com dúvida? A equipe do BLH mais '
                                  'próximo responde pelo WhatsApp cadastrado '
                                  'no seu perfil.',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
