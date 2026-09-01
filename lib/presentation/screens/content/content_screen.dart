import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/presentation/controllers/content_controller.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/article_cards.dart';
import 'package:lactarehub/presentation/shared/components/async_view.dart';
import 'package:lactarehub/presentation/shared/components/filter_chip_bar.dart';

/// Tela 05 do protótipo — biblioteca de conteúdo educativo.
class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, required this.onOpenArticle});

  final ValueChanged<Article> onOpenArticle;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  final ContentController _controller = ContentController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => Column(
            children: [
              const AppTopBar(title: 'Conteúdo'),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.xl,
                  AppSpacing.page,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aprenda com a gente',
                      style: AppTextStyles.heroTitle.copyWith(fontSize: 25),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Conteúdos para apoiar sua jornada de amamentação e '
                      'doação.',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
              FilterChipBar(
                labels: _controller.filterLabels,
                selectedIndex: _controller.selectedFilterIndex,
                onSelected: _controller.selectFilter,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: AsyncView<Article>(
                  isLoading: _controller.isLoading,
                  items: _controller.articles,
                  emptyMessage:
                      'Ainda não há conteúdos publicados nessa categoria.',
                  builder: (articles) => ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      0,
                      AppSpacing.page,
                      AppSpacing.section,
                    ),
                    itemCount: articles.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.lg),
                    itemBuilder: (context, index) => ArticleCard(
                      article: articles[index],
                      onTap: widget.onOpenArticle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
