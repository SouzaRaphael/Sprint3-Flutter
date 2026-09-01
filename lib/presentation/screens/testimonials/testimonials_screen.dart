import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/presentation/controllers/testimonials_controller.dart';
import 'package:lactarehub/presentation/screens/testimonials/components/testimonial_card.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/async_view.dart';
import 'package:lactarehub/presentation/shared/components/filter_chip_bar.dart';

/// Tela 04 do protótipo — depoimentos das doadoras da rede.
class TestimonialsScreen extends StatefulWidget {
  const TestimonialsScreen({
    super.key,
    required this.goBack,
    required this.onWriteTestimonial,
  });

  final VoidCallback goBack;

  /// Assíncrono para que a lista possa recarregar quando a tela de escrita
  /// for fechada.
  final Future<void> Function() onWriteTestimonial;

  @override
  State<TestimonialsScreen> createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  final TestimonialsController _controller = TestimonialsController();

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

  /// Recarrega ao voltar da tela de escrita, para mostrar o novo depoimento.
  Future<void> _openWriter() async {
    await widget.onWriteTestimonial();
    if (mounted) await _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => Column(
            children: [
              AppTopBar(title: 'Depoimentos', onBack: widget.goBack),
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
                      'Histórias que nos movem',
                      style: AppTextStyles.heroTitle.copyWith(
                        fontSize: 25,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Pessoas reais, gestos que transformam outras famílias.',
                      style: AppTextStyles.body,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SegmentedFilter(
                      labels: _controller.filterLabels,
                      selectedIndex: _controller.selectedFilterIndex,
                      onSelected: _controller.selectFilter,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AsyncView<Testimonial>(
                  isLoading: _controller.isLoading,
                  items: _controller.testimonials,
                  emptyMessage:
                      'Ainda não há depoimentos nesse filtro. Que tal ser a '
                      'primeira a escrever?',
                  builder: (testimonials) => ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      0,
                      AppSpacing.page,
                      AppSpacing.section,
                    ),
                    itemCount: testimonials.length + 1,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index == testimonials.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.lg),
                          child: ShareStoryCard(onWrite: _openWriter),
                        );
                      }
                      return TestimonialCard(testimonial: testimonials[index]);
                    },
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
