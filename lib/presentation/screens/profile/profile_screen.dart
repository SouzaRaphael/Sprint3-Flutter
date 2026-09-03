import 'package:flutter/material.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/core/utils/formatters.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/avatar_circle.dart';
import 'package:lactarehub/presentation/shared/components/empty_state_card.dart';
import 'package:lactarehub/presentation/shared/components/info_row.dart';
import 'package:lactarehub/presentation/shared/components/secondary_button.dart';
import 'package:lactarehub/presentation/shared/components/stat_tile.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Perfil da doadora: dados do cadastro e a coleta agendada no momento.
///
/// Recebe o [Donor] da sessão por `settings.arguments` e busca a agenda ao
/// abrir. Como é empurrada como rota nova a cada vez, sempre reflete o último
/// agendamento — inclusive um acabado de registrar ou alterar.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.donor,
    required this.goBack,
    required this.onScheduleCollection,
    required this.onSignedOut,
  });

  final Donor donor;
  final VoidCallback goBack;

  /// Fecha o perfil pedindo à casca que abra a aba de agendamento.
  final VoidCallback onScheduleCollection;

  final VoidCallback onSignedOut;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionSchedule? _schedule;
  bool _isLoadingSchedule = true;
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
    _loadSchedule();
  }

  Future<void> _loadSchedule() async {
    final schedule = await ServiceLocator.getNextCollection();
    if (!mounted) return;
    setState(() {
      _schedule = schedule;
      _isLoadingSchedule = false;
    });
  }

  Future<void> _signOut() async {
    setState(() => _isSigningOut = true);
    await ServiceLocator.signOut();
    if (!mounted) return;
    widget.onSignedOut();
  }

  @override
  Widget build(BuildContext context) {
    final donor = widget.donor;

    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(title: 'Meu perfil', onBack: widget.goBack),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.xl,
                  AppSpacing.page,
                  AppSpacing.section,
                ),
                children: [
                  _ProfileHeader(donor: donor),
                  const SizedBox(height: AppSpacing.xxl),
                  _NextCollectionSection(
                    schedule: _schedule,
                    isLoading: _isLoadingSchedule,
                    onSchedule: widget.onScheduleCollection,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ProfileCard(
                    title: 'Contato',
                    children: [
                      InfoRow(
                        icon: Icons.alternate_email,
                        label: 'E-mail',
                        value: donor.email,
                      ),
                      InfoRow(
                        icon: Icons.phone_iphone,
                        label: 'Telefone / WhatsApp',
                        value: donor.phone,
                      ),
                      InfoRow(
                        icon: Icons.cake_outlined,
                        label: 'Data de nascimento',
                        value: donor.birthDate,
                        bottomSpacing: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ProfileCard(
                    title: 'Endereço',
                    children: [
                      InfoRow(
                        icon: Icons.markunread_mailbox_outlined,
                        label: 'CEP',
                        value: donor.zipCode,
                      ),
                      InfoRow(
                        icon: Icons.home_outlined,
                        label: 'Logradouro',
                        value: '${donor.street}, ${donor.number}',
                      ),
                      InfoRow(
                        icon: Icons.place_outlined,
                        label: 'Bairro e cidade',
                        value: '${donor.neighborhood} — ${donor.cityAndState}',
                        bottomSpacing: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ProfileCard(
                    title: 'Triagem',
                    children: [
                      InfoRow(
                        icon: Icons.child_care_outlined,
                        label: 'Idade do bebê',
                        value: donor.babyAgeMonths.isEmpty
                            ? ''
                            : '${donor.babyAgeMonths} meses',
                      ),
                      InfoRow(
                        icon: Icons.volunteer_activism_outlined,
                        label: 'Amamentando',
                        value: donor.isBreastfeeding ? 'Sim' : 'Não',
                      ),
                      InfoRow(
                        icon: Icons.medication_outlined,
                        label: 'Medicamento contínuo',
                        value: donor.takesMedication
                            ? (donor.medicationNotes.isEmpty
                                  ? 'Sim'
                                  : donor.medicationNotes)
                            : 'Não',
                        bottomSpacing: 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _JourneySummary(donor: donor),
                  const SizedBox(height: AppSpacing.lg),
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
                          Icons.lock_outline,
                          size: 19,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            'Seus dados de saúde ficam visíveis apenas para '
                            'você e para a equipe do banco de leite.',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  SecondaryButton(
                    label: _isSigningOut ? 'Saindo…' : 'Sair da conta',
                    icon: Icons.logout,
                    foregroundColor: AppColors.inkMuted,
                    onPressed: _isSigningOut ? null : _signOut,
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

/// Card da coleta marcada, ou o convite para marcar a primeira.
class _NextCollectionSection extends StatelessWidget {
  const _NextCollectionSection({
    required this.schedule,
    required this.isLoading,
    required this.onSchedule,
  });

  final CollectionSchedule? schedule;
  final bool isLoading;
  final VoidCallback onSchedule;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 120,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final next = schedule;
    if (next == null) {
      return EmptyStateCard(
        icon: Icons.event_available_outlined,
        title: 'Nenhuma coleta agendada',
        message: 'Marque a próxima coleta para acompanhar tudo por aqui.',
        actionLabel: 'Agendar coleta',
        onAction: onSchedule,
      );
    }

    return _ProfileCard(
      title: 'Próxima coleta',
      trailing: next.isConfirmed
          ? StatusBadge(
              label: 'Confirmada',
              background: AppColors.successBg,
              foreground: AppColors.successFg,
              icon: Icons.check_circle_outline,
            )
          : StatusBadge(
              label: 'Aguardando confirmação',
              background: AppColors.tintBlue,
              foreground: AppColors.primary,
              icon: Icons.schedule,
            ),
      children: [
        InfoRow(
          icon: Icons.event_outlined,
          label: 'Data',
          value: '${Formatters.weekdayAndDate(next.scheduledAt)} de '
              '${next.scheduledAt.year}',
        ),
        InfoRow(
          icon: Icons.access_time,
          label: 'Janela de horário',
          value: next.timeWindow,
        ),
        InfoRow(
          icon: Icons.local_shipping_outlined,
          label: 'Modalidade',
          value: next.mode.label,
        ),
        InfoRow(
          icon: Icons.place_outlined,
          label: 'Local',
          value: next.place,
          bottomSpacing: next.notes.trim().isEmpty ? 0 : AppSpacing.lg,
        ),
        if (next.notes.trim().isNotEmpty)
          InfoRow(
            icon: Icons.sticky_note_2_outlined,
            label: 'Observações',
            value: next.notes,
            bottomSpacing: 0,
          ),
      ],
    );
  }
}

/// Avatar, nome e situação da jornada.
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.donor});

  final Donor donor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarCircle(
          name: donor.fullName,
          gradientIndex: donor.avatarGradientIndex,
          size: 84,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          donor.fullName,
          textAlign: TextAlign.center,
          style: AppTextStyles.heroTitle.copyWith(fontSize: 23),
        ),
        const SizedBox(height: 4),
        Text(donor.cityAndState, style: AppTextStyles.bodySmall),
        const SizedBox(height: AppSpacing.md),
        StatusBadge(
          label: donor.isStartingJourney
              ? 'Cadastro concluído'
              : 'Doadora ativa',
          background: donor.isStartingJourney
              ? AppColors.tintBlue
              : AppColors.successBg,
          foreground: donor.isStartingJourney
              ? AppColors.primary
              : AppColors.successFg,
          icon: donor.isStartingJourney
              ? Icons.check_circle_outline
              : Icons.favorite,
        ),
      ],
    );
  }
}

/// Card branco com título, selo opcional e uma sequência de [InfoRow].
class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;
  final List<Widget> children;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
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
                child: Text(title, style: AppTextStyles.cardTitleBlue),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSpacing.sm),
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

/// Números da jornada, no mesmo formato do card de impacto da home.
class _JourneySummary extends StatelessWidget {
  const _JourneySummary({required this.donor});

  final Donor donor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.largeCardBR,
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: StatTile(
                value: '${donor.completedDonations}',
                label: 'doações',
                alignment: CrossAxisAlignment.center,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: StatTile(
                value: Formatters.liters(donor.donatedMilliliters),
                label: 'doados',
                alignment: CrossAxisAlignment.center,
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: StatTile(
                value: '~${donor.babiesReached}',
                label: 'bebês alcançados',
                valueColor: AppColors.pinkStrong,
                alignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
