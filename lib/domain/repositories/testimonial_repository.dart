import 'package:lactarehub/domain/entities/testimonial.dart';

/// Depoimentos das doadoras.
abstract class TestimonialRepository {
  Future<List<Testimonial>> listTestimonials();

  /// Publica um novo depoimento e devolve a lista já atualizada.
  Future<List<Testimonial>> submit(Testimonial testimonial);
}
