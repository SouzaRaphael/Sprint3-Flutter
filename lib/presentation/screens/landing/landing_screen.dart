import 'package:flutter/material.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/how_it_works_step.dart';
import 'package:lactarehub/domain/entities/impact_stats.dart';
import 'package:lactarehub/presentation/screens/landing/components/hero_section.dart';
import 'package:lactarehub/presentation/screens/landing/components/how_it_works_section.dart';
import 'package:lactarehub/presentation/screens/landing/components/impact_band.dart';
import 'package:lactarehub/presentation/screens/landing/components/landing_header.dart';
import 'package:lactarehub/presentation/screens/landing/components/landing_sections.dart';

/// Tela 01 do protótipo — apresentação pública do Lactare.
class LandingScreen extends StatefulWidget {
  const LandingScreen({
    super.key,
    required this.onStartDonation,
    required this.onLogin,
    required this.onOpenMap,
    required this.onOpenContent,
    required this.onOpenTestimonials,
  });

  final VoidCallback onStartDonation;
  final VoidCallback onLogin;
  final VoidCallback onOpenMap;
  final VoidCallback onOpenContent;
  final VoidCallback onOpenTestimonials;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _howItWorksKey = GlobalKey();

  ImpactStats? _stats;
  List<HowItWorksStep> _steps = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final stats = await ServiceLocator.getImpactStats();
    final steps = await ServiceLocator.listHowItWorksSteps();
    if (!mounted) return;
    setState(() {
      _stats = stats;
      _steps = steps;
      _isLoading = false;
    });
  }

  /// "Como funciona" rola a página até a seção dos três passos.
  void _scrollToHowItWorks() {
    final context = _howItWorksKey.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stats = _stats;

    return Scaffold(
      backgroundColor: AppColors.bgLanding,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            LandingHeader(onLogin: widget.onLogin),
            Expanded(
              child: _isLoading || stats == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          HeroSection(
                            stats: stats,
                            heroStates: stats.highlightedStates,
                            onStartDonation: widget.onStartDonation,
                            onHowItWorks: _scrollToHowItWorks,
                          ),
                          ImpactBand(stats: stats),
                          HowItWorksSection(
                            key: _howItWorksKey,
                            steps: _steps,
                            onOpenGuide: widget.onOpenContent,
                          ),
                          _StoriesTeaser(onOpen: widget.onOpenTestimonials),
                          // MapTeaserSection(onOpenMap: widget.onOpenMap),
                          // ProfessionalsSection(onLogin: widget.onLogin),
                          const LandingFooter(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Convite para a tela de depoimentos.
class _StoriesTeaser extends StatelessWidget {
  const _StoriesTeaser({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.page,
        vertical: AppSpacing.section,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.tintBlue,
          borderRadius: AppRadius.largeCardBR,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.format_quote,
              size: 30,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Histórias que nos movem',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 21),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Pessoas reais, gestos que transformam outras famílias.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            GestureDetector(
              onTap: onOpen,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ler depoimentos',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.primary,
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
