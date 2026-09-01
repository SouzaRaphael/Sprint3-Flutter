import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/domain/repositories/testimonial_repository.dart';

/// Lista os depoimentos, opcionalmente por tipo de doadora.
class ListTestimonials {
  final TestimonialRepository _repository;
  const ListTestimonials(this._repository);

  Future<List<Testimonial>> call({TestimonialType? type}) async {
    final testimonials = await _repository.listTestimonials();
    if (type == null) return testimonials;
    return testimonials.where((item) => item.type == type).toList();
  }
}
