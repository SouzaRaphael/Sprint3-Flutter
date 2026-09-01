/// Símbolos dos três passos apresentados na landing.
enum HowItWorksIcon { pessoa, local, coracao }

/// Um dos passos da seção "Em 3 passos você se torna parte da rede".
class HowItWorksStep {
  /// Numeral exibido em destaque: `01`, `02`, `03`.
  final String number;
  final String title;
  final String description;
  final HowItWorksIcon icon;

  const HowItWorksStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });
}
