import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/controllers/donor_home_controller.dart';
import 'package:lactarehub/presentation/screens/donor_home/components/donation_preview_card.dart';
import 'package:lactarehub/presentation/screens/donor_home/components/impact_summary_card.dart';
import 'package:lactarehub/presentation/screens/donor_home/components/next_collection_card.dart';
import 'package:lactarehub/presentation/screens/donor_home/components/quick_actions_row.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/article_cards.dart';
import 'package:lactarehub/presentation/shared/components/avatar_circle.dart';
import 'package:lactarehub/presentation/shared/components/section_title.dart';

/// Tela 07 do protótipo — home da doadora autenticada.
class DonorHomeScreen extends StatefulWidget {
  const DonorHomeScreen({
    super.key,
    required this.onOpenSchedule,
    required this.onOpenPoints,
    required this.onOpenContent,
    required this.onOpenTestimonials,
    required this.onOpenMyArea,
    required this.onOpenArticle,
    required this.onOpenDonation,
  });

  final VoidCallback onOpenSchedule;
  final VoidCallback onOpenPoints;
  final VoidCallback onOpenContent;
  final VoidCallback onOpenTestimonials;
  final VoidCallback onOpenMyArea;
  final ValueChanged<Article> onOpenArticle;
  final ValueChanged<Donation> onOpenDonation;

  @override
  State<DonorHomeScreen> createState() => _DonorHomeScreenState();
}

class _DonorHomeScreenState extends State<DonorHomeScreen> {
  final DonorHomeController _controller = DonorHomeController();

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

  Future<void> _confirm() async {
    await _controller.confirmCollection();
    if (!mounted) return;
    AppFeedback.success(
      context,
      'Coleta confirmada! A equipe já foi avisada.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final donor = _controller.donor;
            final schedule = _controller.schedule;
            final donation = _controller.currentDonation;

            if (_controller.isLoading ||
                donor == null ||
                schedule == null ||
                donation == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: _controller.load,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.lg,
                  AppSpacing.page,
                  AppSpacing.section,
                ),
                children: [
                  _Greeting(name: donor.firstName, gradientIndex: donor.avatarGradientIndex),
                  const SizedBox(height: AppSpacing.xl),
                  Text.rich(
                    TextSpan(
                      style: AppTextStyles.heroTitle.copyWith(fontSize: 23),
                      children: [
                        const TextSpan(text: 'Sua próxima coleta é '),
                        TextSpan(
                          text: Formatters.daysUntil(
                            schedule.scheduledAt,
                            schedule.referenceToday,
                          ),
                          style: AppTextStyles.heroTitle.copyWith(
                            fontSize: 23,
                            color: AppColors.accent,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Em nome de muitas famílias, agradecemos a sua '
                    'generosidade.',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  NextCollectionCard(
                    schedule: schedule,
                    isConfirming: _controller.isConfirming,
                    onConfirm: _confirm,
                    onReschedule: widget.onOpenSchedule,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  QuickActionsRow(
                    actions: [
                      QuickAction(
                        icon: Icons.add,
                        label: 'Nova coleta',
                        isHighlighted: true,
                        onTap: widget.onOpenSchedule,
                      ),
                      QuickAction(
                        icon: Icons.location_on_outlined,
                        label: 'Pontos',
                        onTap: widget.onOpenPoints,
                      ),
                      QuickAction(
                        icon: Icons.card_giftcard_outlined,
                        label: 'Indicar',
                        onTap: () => AppFeedback.info(
                          context,
                          'Link de convite gerado! Compartilhe com quem você '
                          'quer trazer para a rede.',
                        ),
                      ),
                      QuickAction(
                        icon: Icons.menu_book_outlined,
                        label: 'Aprender',
                        onTap: widget.onOpenContent,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const SectionTitle(title: 'Seu impacto até aqui'),
                  const SizedBox(height: AppSpacing.lg),
                  ImpactSummaryCard(
                    donor: donor,
                    onOpenAchievements: widget.onOpenMyArea,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const SectionTitle(title: 'Acompanhe sua doação'),
                  const SizedBox(height: AppSpacing.lg),
                  DonationPreviewCard(
                    donation: donation,
                    onTap: widget.onOpenDonation,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TeamMessageCard(
                    donorFirstName: donor.firstName,
                    hospital: donation.destinationHospital,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const SectionTitle(title: 'Para ler nesta semana'),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _controller.featuredArticles.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, index) => ArticleCarouselCard(
                        article: _controller.featuredArticles[index],
                        onTap: widget.onOpenArticle,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Saudação com avatar e sino de notificações.
class _Greeting extends StatelessWidget {
  const _Greeting({required this.name, required this.gradientIndex});

  final String name;
  final int gradientIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AvatarCircle(name: name, gradientIndex: gradientIndex, size: 42),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bom dia,', style: AppTextStyles.caption),
              Text(
                name,
                style: AppTextStyles.cardTitleBlue.copyWith(fontSize: 17),
              ),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none,
              size: 25,
              color: AppColors.primaryDark,
            ),
            Positioned(
              right: 1,
              top: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.pinkStrong,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
