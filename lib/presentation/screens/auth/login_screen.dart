import 'package:flutter/material.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_spacing.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/domain/entities/test_credential.dart';
import 'package:lactarehub/presentation/controllers/login_controller.dart';
import 'package:lactarehub/presentation/screens/auth/components/google_sign_in_button.dart';
import 'package:lactarehub/presentation/screens/auth/components/test_credentials_box.dart';
import 'package:lactarehub/presentation/shared/components/app_feedback.dart';
import 'package:lactarehub/presentation/shared/components/app_text_field.dart';
import 'package:lactarehub/presentation/shared/components/lactare_logo.dart';
import 'package:lactarehub/presentation/shared/components/primary_button.dart';

/// Tela 02 do protótipo — acesso à área da doadora.
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onSignedIn,
    required this.onRegister,
    required this.goBack,
  });

  final VoidCallback onSignedIn;
  final VoidCallback onRegister;
  final VoidCallback goBack;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _controller = LoginController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  late final List<TestCredential> _credentials =
      ServiceLocator.getTestCredentials();

  @override
  void dispose() {
    _controller.dispose();
    _emailField.dispose();
    _passwordField.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final signedIn = await _controller.signIn(
      email: _emailField.text,
      password: _passwordField.text,
    );
    if (!mounted) return;

    if (signedIn) {
      AppFeedback.success(
        context,
        'Bem-vinda de volta, ${_controller.session?.name ?? ''}!',
      );
      widget.onSignedIn();
    } else {
      AppFeedback.error(
        context,
        _controller.errorMessage ?? 'Não foi possível entrar.',
      );
    }
  }

  void _fillWith(TestCredential credential) {
    _emailField.text = credential.email;
    _passwordField.text = credential.password;
    AppFeedback.info(context, 'Credenciais de ${credential.roleLabel} '
        'preenchidas. Toque em Entrar.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page,
              AppSpacing.lg,
              AppSpacing.page,
              AppSpacing.section,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LactareLogo(),
                      IconButton(
                        onPressed: widget.goBack,
                        icon: const Icon(Icons.close),
                        color: AppColors.navInactive,
                        tooltip: 'Voltar',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Bem-vinda de volta',
                    style: AppTextStyles.heroTitle.copyWith(fontSize: 27),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Entre na sua conta para continuar fazendo a diferença.',
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  AppTextField(
                    label: 'E-mail',
                    hint: 'seu@email.com',
                    controller: _emailField,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return 'Informe o seu e-mail.';
                      if (!text.contains('@') || !text.contains('.')) {
                        return 'Informe um e-mail válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppTextField(
                    label: 'Senha',
                    hint: 'Sua senha',
                    controller: _passwordField,
                    obscureText: _controller.obscurePassword,
                    trailingLabel: 'Esqueceu a senha?',
                    onTrailingTap: () => AppFeedback.info(
                      context,
                      'Enviamos um link de redefinição para o seu e-mail.',
                    ),
                    suffix: IconButton(
                      onPressed: _controller.togglePasswordVisibility,
                      icon: Icon(
                        _controller.obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.navInactive,
                        size: 20,
                      ),
                    ),
                    validator: (value) => (value ?? '').isEmpty
                        ? 'Informe a sua senha.'
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Entrar',
                    isLoading: _controller.isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const _OrDivider(),
                  const SizedBox(height: AppSpacing.xl),
                  GoogleSignInButton(
                    onPressed: () => AppFeedback.info(
                      context,
                      'Acesso com Google disponível na próxima entrega.',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Center(
                    child: GestureDetector(
                      onTap: widget.onRegister,
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.bodySmall,
                          children: [
                            const TextSpan(text: 'Ainda não tem conta? '),
                            TextSpan(
                              text: 'Cadastre-se',
                              style: AppTextStyles.label.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  TestCredentialsBox(
                    credentials: _credentials,
                    onUseCredential: _fillWith,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Center(
                    child: Text(
                      '© 2026 Lactare. Todos os direitos reservados.',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text('ou', style: AppTextStyles.caption),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
