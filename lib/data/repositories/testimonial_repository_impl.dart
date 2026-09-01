import 'package:lactarehub/data/datasources/testimonial_mock_datasource.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/domain/repositories/testimonial_repository.dart';

/// Depoimentos sobre os dados mockados.
///
/// O que a doadora publica entra no topo da lista e permanece enquanto o
/// aplicativo estiver aberto.
class TestimonialRepositoryImpl implements TestimonialRepository {
  static const Duration _latency = Duration(milliseconds: 250);

  @override
  Future<List<Testimonial>> listTestimonials() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(TestimonialMockDatasource.items);
  }

  @override
  Future<List<Testimonial>> submit(Testimonial testimonial) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    TestimonialMockDatasource.items.insert(0, testimonial);
    return List.unmodifiable(TestimonialMockDatasource.items);
  }
}
