import 'package:flutter/material.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_radius.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/donor.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/presentation/controllers/testimonials_controller.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';
import 'package:lactarehub/presentation/shared/components/status_badge.dart';

/// Formulário de publicação de depoimento, aberto pelo card
/// "Compartilhe sua história".
class WriteTestimonialScreen extends StatefulWidget {
  const WriteTestimonialScreen({super.key, required this.goBack});

  final VoidCallback goBack;

  @override
  State<WriteTestimonialScreen> createState() => _WriteTestimonialScreenState();
}

class _WriteTestimonialScreenState extends State<WriteTestimonialScreen> {
  final TestimonialsController _controller = TestimonialsController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _messageField = TextEditingController();

  Donor? _donor;
  TestimonialType _type = TestimonialType.recorrente;

  @override
  void initState() {
    super.initState();
    _loadDonor();
  }

  @override
  void dispose() {
    _controller.dispose();
    _messageField.dispose();
    super.dispose();
  }

  Future<void> _loadDonor() async {
    final donor = await ServiceLocator.getDonorProfile();
    if (!mounted) return;
    setState(() => _donor = donor);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final donor = _donor;
    if (donor == null) return;

    final published = await _controller.submit(
      Testimonial(
        id: 'dep-${DateTime.now().millisecondsSinceEpoch}',
        authorName: donor.fullName,
        city: donor.city,
        state: donor.state,
        message: _messageField.text.trim(),
        type: _type,
        avatarGradientIndex: donor.avatarGradientIndex,
      ),
    );

    if (!mounted || !published) return;
    AppFeedback.success(
      context,
      'Depoimento publicado! Obrigado por inspirar outras doadoras.',
    );
    widget.goBack();
  }

  @override
  Widget build(BuildContext context) {
    final donor = _donor;

    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => Column(
            children: [
              AppTopBar(title: 'Escrever depoimento', onBack: widget.goBack),
              Expanded(
                child: donor == null
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                        key: _formKey,
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.page,
                            AppSpacing.xl,
                            AppSpacing.page,
                            AppSpacing.xl,
                          ),
                          children: [
                            Text(
                              'Conte como foi para você',
                              style: AppTextStyles.heroTitle.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Seu relato aparece na lista pública assinado '
                              'como ${donor.fullName}, de ${donor.cityAndState}.',
                              style: AppTextStyles.body,
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            Text(
                              'Como você se descreve hoje?',
                              style: AppTextStyles.label,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                for (final type in TestimonialType.values)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: AppSpacing.sm,
                                    ),
                                    child: _TypeChoice(
                                      type: type,
                                      isSelected: type == _type,
                                      onTap: () => setState(() => _type = type),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            AppTextField(
                              label: 'Seu depoimento',
                              hint: 'O que a doação mudou na sua rotina?',
                              controller: _messageField,
                              maxLines: 6,
                              textCapitalization:
                                  TextCapitalization.sentences,
                              validator: (value) {
                                final text = (value ?? '').trim();
                                if (text.length < 20) {
                                  return 'Escreva ao menos 20 caracteres.';
                                }
                                return null;
                              },
                            ),
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
                                    Icons.shield_outlined,
                                    size: 19,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Text(
                                      'Nenhum dado de saúde é publicado. Você '
                                      'pode pedir a remoção do depoimento a '
                                      'qualquer momento.',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.primaryDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            PrimaryButton(
                              label: 'Publicar depoimento',
                              icon: Icons.send_outlined,
                              showTrailingIcon: false,
                              isLoading: _controller.isSubmitting,
                              onPressed: _submit,
                            ),
                          ],
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

/// Escolha entre "1ª doação" e "Recorrente".
class _TypeChoice extends StatelessWidget {
  const _TypeChoice({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final TestimonialType type;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1 : 0.45,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppRadius.pillBR,
            border: Border.all(
              color: isSelected ? AppColors.accent : Colors.transparent,
              width: 1.6,
            ),
          ),
          padding: const EdgeInsets.all(2),
          child: StatusBadge.testimonial(type),
        ),
      ),
    );
  }
}
