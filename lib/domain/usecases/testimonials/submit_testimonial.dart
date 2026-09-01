import 'package:lactarehub/domain/entities/testimonial.dart';
import 'package:lactarehub/domain/repositories/testimonial_repository.dart';

/// Publica o depoimento escrito pela doadora.
class SubmitTestimonial {
  final TestimonialRepository _repository;
  const SubmitTestimonial(this._repository);

  Future<List<Testimonial>> call(Testimonial testimonial) =>
      _repository.submit(testimonial);
}
