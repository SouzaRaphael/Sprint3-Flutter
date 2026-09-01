/// Estágio de uma conquista na trilha da doadora.
enum AchievementStatus { conquistada, emProgresso, bloqueada }

extension AchievementStatusLabel on AchievementStatus {
  String get label => switch (this) {
    AchievementStatus.conquistada => 'Conquistada',
    AchievementStatus.emProgresso => 'Em progresso',
    AchievementStatus.bloqueada => 'Bloqueada',
  };
}

/// Medalha exibida no grid da área da doadora.
class Achievement {
  final String id;
  final String title;

  /// Texto de progresso: `14 doações`, `2/5 indicações`.
  final String progressLabel;
  final AchievementStatus status;

  /// Índice do gradiente em `AppColors.avatarGradients`.
  final int gradientIndex;

  /// Nome do ícone Material equivalente ao símbolo do design.
  final AchievementIcon icon;

  const Achievement({
    required this.id,
    required this.title,
    required this.progressLabel,
    required this.status,
    required this.gradientIndex,
    required this.icon,
  });
}

/// Símbolos usados nas medalhas, mantidos no domínio para que a camada
/// de dados não precise conhecer o pacote de ícones.
enum AchievementIcon { gota, medalha, estrela, coracao, folha, brilho }
