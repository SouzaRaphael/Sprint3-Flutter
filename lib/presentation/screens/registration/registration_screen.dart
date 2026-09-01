import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/presentation/controllers/registration_controller.dart';
import 'package:lactarehub/presentation/screens/registration/components/registration_fields.dart';
import 'package:lactarehub/presentation/screens/registration/components/registration_progress.dart';
import 'package:lactarehub/presentation/screens/registration/steps/step_about_you.dart';
import 'package:lactarehub/presentation/screens/registration/steps/step_address.dart';
import 'package:lactarehub/presentation/screens/registration/steps/step_health.dart';
import 'package:lactarehub/presentation/screens/registration/steps/step_review.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_top_bar.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';

/// Tela 03 do protótipo — cadastro da doadora em quatro etapas.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
    required this.onCompleted,
    required this.goBack,
  });

  final VoidCallback onCompleted;
  final VoidCallback goBack;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final RegistrationController _controller = RegistrationController();
  final RegistrationFields _fields = RegistrationFields();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    _fields.dispose();
    super.dispose();
  }

  /// Voltar recua uma etapa; na primeira, sai do cadastro.
  void _handleBack() {
    if (_controller.isFirstStep) {
      widget.goBack();
    } else {
      _controller.goToPreviousStep();
    }
  }

  Future<void> _handleAdvance() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _controller.updateDraft(_fields.applyTo(_controller.draft));

    if (!_controller.isLastStep) {
      _controller.goToNextStep();
      return;
    }

    if (!_controller.draft.acceptedTerms) {
      AppFeedback.error(
        context,
        'Aceite os termos para concluir o seu cadastro.',
      );
      return;
    }

    final completed = await _controller.submit();
    if (!mounted || !completed) return;
    widget.onCompleted();
  }

  Widget _buildStep() => switch (_controller.step) {
    RegistrationStep.sobreVoce => StepAboutYou(fields: _fields),
    RegistrationStep.endereco => StepAddress(fields: _fields),
    RegistrationStep.saude => StepHealth(
      fields: _fields,
      draft: _controller.draft,
      onChanged: _controller.updateDraft,
    ),
    RegistrationStep.revisao => StepReview(
      draft: _controller.draft,
      onChanged: _controller.updateDraft,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => Column(
            children: [
              AppTopBar(title: 'Cadastro', onBack: _handleBack),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.page,
                      AppSpacing.xl,
                      AppSpacing.page,
                      AppSpacing.xl,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegistrationProgress(
                          currentStep: _controller.stepNumber,
                          totalSteps: _controller.totalSteps,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          _controller.step.title,
                          style: AppTextStyles.heroTitle.copyWith(fontSize: 26),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          _controller.step.subtitle,
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        _buildStep(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.page,
                  AppSpacing.md,
                  AppSpacing.page,
                  AppSpacing.xl,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.bgApp,
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: PrimaryButton(
                  label: _controller.isLastStep
                      ? 'Finalizar cadastro'
                      : 'Continuar',
                  isLoading: _controller.isSubmitting,
                  showTrailingIcon: !_controller.isLastStep,
                  icon: _controller.isLastStep ? Icons.check : null,
                  onPressed: _handleAdvance,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
