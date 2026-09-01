/// Recorte usado nos filtros da tela de depoimentos.
enum TestimonialType { primeiraDoacao, recorrente }

extension TestimonialTypeLabel on TestimonialType {
  String get label => switch (this) {
    TestimonialType.primeiraDoacao => '1ª doação',
    TestimonialType.recorrente => 'Recorrente',
  };

  String get filterLabel => switch (this) {
    TestimonialType.primeiraDoacao => 'Primeira doação',
    TestimonialType.recorrente => 'Recorrentes',
  };
}

/// Depoimento de uma doadora da rede.
class Testimonial {
  final String id;
  final String authorName;
  final String city;
  final String state;
  final String message;
  final TestimonialType type;

  /// Índice do gradiente de avatar em `AppColors.avatarGradients`.
  final int avatarGradientIndex;

  const Testimonial({
    required this.id,
    required this.authorName,
    required this.city,
    required this.state,
    required this.message,
    required this.type,
    required this.avatarGradientIndex,
  });

  String get cityAndState => '$city, $state';
}
