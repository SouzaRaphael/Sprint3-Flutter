import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/controllers/my_area_controller.dart';
import 'package:lactarehub/presentation/screens/my_area/components/achievements_grid.dart';
import 'package:lactarehub/presentation/screens/my_area/components/journey_card.dart';
import 'package:lactarehub/presentation/screens/my_area/components/referral_card.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/article_cards.dart';
import 'package:lactarehub/presentation/shared/components/avatar_circle.dart';
import 'package:lactarehub/presentation/shared/components/lactare_logo.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/section_title.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';
import 'package:lactarehub/presentation/shared/components/tracking_timeline.dart';

/// Tela 08 do protótipo — área pessoal da doadora.
class MyAreaScreen extends StatefulWidget {
  const MyAreaScreen({
    super.key,
    required this.onOpenSchedule,
    required this.onOpenArticle,
    required this.onOpenDonation,
    required this.onOpenTestimonials,
  });

  final VoidCallback onOpenSchedule;
  final ValueChanged<Article> onOpenArticle;
  final ValueChanged<Donation> onOpenDonation;
  final VoidCallback onOpenTestimonials;

  @override
  State<MyAreaScreen> createState() => _MyAreaScreenState();
}

class _MyAreaScreenState extends State<MyAreaScreen> {
  final MyAreaController _controller = MyAreaController();

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
                  Row(
                    children: [
                      const LactareLogo(variant: LactareLogoVariant.rounded),
                      const Spacer(),
                      const Icon(
                        Icons.notifications_none,
                        size: 24,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      AvatarCircle(
                        name: donor.fullName,
                        gradientIndex: donor.avatarGradientIndex,
                        size: 38,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Olá,', style: AppTextStyles.body),
                  const SizedBox(height: 2),
                  Text(
                    '${donor.firstName}, obrigado por fazer parte do Lactare',
                    style: AppTextStyles.heroTitle.copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  JourneyCard(donor: donor, schedule: schedule),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'Agendar nova coleta',
                    icon: Icons.calendar_month_outlined,
                    showTrailingIcon: false,
                    onPressed: widget.onOpenSchedule,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const SectionTitle(title: 'Rastreamento da sua doação'),
                  const SizedBox(height: AppSpacing.lg),
                  _TrackingCard(
                    donation: donation,
                    onTap: () => widget.onOpenDonation(donation),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SectionTitle(
                    title: 'Suas conquistas',
                    actionLabel: 'Histórias',
                    onAction: widget.onOpenTestimonials,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AchievementsGrid(
                    achievements: _controller.achievements,
                    onTap: (achievement) => AppFeedback.info(
                      context,
                      '${achievement.title}: ${achievement.progressLabel}.',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  ReferralCard(
                    onInvite: () => AppFeedback.success(
                      context,
                      'Convite pronto para compartilhar com quem você quiser.',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const SectionTitle(title: 'Para você ler agora'),
                  const SizedBox(height: AppSpacing.lg),
                  for (final article in _controller.readings) ...[
                    ArticleListTile(
                      article: article,
                      onTap: widget.onOpenArticle,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Card branco com o código da doação e a linha do tempo resumida.
class _TrackingCard extends StatelessWidget {
  const _TrackingCard({required this.donation, required this.onTap});

  final Donation donation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.largeCardBR,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: AppRadius.largeCardBR,
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Doação #${donation.code}',
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Coletada em '
                          '${Formatters.paddedDate(donation.collectedAt)}',
                          style: AppTextStyles.cardTitleBlue.copyWith(
                            fontSize: 15.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  StatusBadge.donation(donation.status),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              TrackingTimeline(steps: donation.timeline),
            ],
          ),
        ),
      ),
    );
  }
}
