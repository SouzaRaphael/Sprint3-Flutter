/// Natureza do ponto exibido no mapa.
enum CollectionPointType { blh, postoDeColeta, coletaDomiciliar }

extension CollectionPointTypeLabel on CollectionPointType {
  String get label => switch (this) {
    CollectionPointType.blh => 'BLH',
    CollectionPointType.postoDeColeta => 'Posto de coleta',
    CollectionPointType.coletaDomiciliar => 'Coleta domiciliar',
  };
}

/// Banco de Leite Humano, posto de coleta ou área de coleta domiciliar.
class CollectionPoint {
  final String id;
  final String name;
  final CollectionPointType type;
  final double distanceKm;
  final String openingHours;
  final String address;
  final String neighborhood;
  final String phone;
  final bool isOpenNow;

  /// Posição relativa no mapa ilustrado (0..1 em cada eixo).
  final double mapX;
  final double mapY;

  const CollectionPoint({
    required this.id,
    required this.name,
    required this.type,
    required this.distanceKm,
    required this.openingHours,
    required this.address,
    required this.neighborhood,
    required this.phone,
    required this.isOpenNow,
    required this.mapX,
    required this.mapY,
  });

  /// Linha de resumo mostrada sob o nome: `BLH · 1.2 km · 08h-18h`.
  String get summary =>
      '${type.label} · ${distanceKm.toStringAsFixed(1)} km · $openingHours';
}
