/// Números agregados da rede, exibidos na landing pública.
class ImpactStats {
  final int litersCollected;
  final int collectionYear;
  final int babiesAssisted;
  final int donorsInNetwork;
  final int connectedBanks;
  final int states;

  /// Siglas exibidas nos avatares empilhados do hero.
  final List<String> highlightedStates;

  const ImpactStats({
    required this.litersCollected,
    required this.collectionYear,
    required this.babiesAssisted,
    required this.donorsInNetwork,
    required this.connectedBanks,
    required this.states,
    required this.highlightedStates,
  });
}
