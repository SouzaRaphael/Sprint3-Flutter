import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/registration_draft.dart';

/// Etapas do cadastro, na ordem em que aparecem na barra de progresso.
enum RegistrationStep { sobreVoce, endereco, saude, revisao }

extension RegistrationStepLabel on RegistrationStep {
  String get title => switch (this) {
    RegistrationStep.sobreVoce => 'Sobre você',
    RegistrationStep.endereco => 'Onde você está',
    RegistrationStep.saude => 'Saúde e triagem',
    RegistrationStep.revisao => 'Revise seus dados',
  };

  String get subtitle => switch (this) {
    RegistrationStep.sobreVoce =>
      'Vamos começar nos conhecendo. Suas informações ficam protegidas.',
    RegistrationStep.endereco =>
      'O endereço define o BLH mais próximo e a área de coleta domiciliar.',
    RegistrationStep.saude =>
      'Uma triagem rápida: a equipe do banco confirma tudo no primeiro contato.',
    RegistrationStep.revisao =>
      'Confira os dados antes de enviar. Você pode voltar e ajustar.',
  };
}

/// Estado do formulário de cadastro em quatro etapas.
class RegistrationController extends ChangeNotifier {
  RegistrationStep _step = RegistrationStep.sobreVoce;
  RegistrationDraft _draft = const RegistrationDraft();
  bool _isSubmitting = false;

  RegistrationStep get step => _step;
  RegistrationDraft get draft => _draft;
  bool get isSubmitting => _isSubmitting;

  int get stepNumber => _step.index + 1;
  int get totalSteps => RegistrationStep.values.length;
  bool get isLastStep => _step == RegistrationStep.revisao;
  bool get isFirstStep => _step == RegistrationStep.sobreVoce;

  void updateDraft(RegistrationDraft draft) {
    _draft = draft;
    notifyListeners();
  }

  void goToNextStep() {
    if (isLastStep) return;
    _step = RegistrationStep.values[_step.index + 1];
    notifyListeners();
  }

  void goToPreviousStep() {
    if (isFirstStep) return;
    _step = RegistrationStep.values[_step.index - 1];
    notifyListeners();
  }

  /// Envia o cadastro. Devolve `true` quando concluído.
  Future<bool> submit() async {
    _isSubmitting = true;
    notifyListeners();
    try {
      await ServiceLocator.registerDonor(_draft);
      return true;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
