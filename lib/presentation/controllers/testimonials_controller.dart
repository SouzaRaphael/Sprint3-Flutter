import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/testimonial.dart';

/// Estado da tela de depoimentos.
class TestimonialsController extends ChangeNotifier {
  List<Testimonial> _testimonials = const [];
  TestimonialType? _type;
  bool _isLoading = true;
  bool _isSubmitting = false;

  List<Testimonial> get testimonials => _testimonials;
  TestimonialType? get type => _type;
  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;

  List<String> get filterLabels => [
    'Todos',
    for (final type in TestimonialType.values) type.filterLabel,
  ];

  int get selectedFilterIndex => _type == null ? 0 : _type!.index + 1;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    _testimonials = await ServiceLocator.listTestimonials(type: _type);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectFilter(int index) async {
    _type = index == 0 ? null : TestimonialType.values[index - 1];
    await load();
  }

  /// Publica o depoimento escrito pela doadora.
  Future<bool> submit(Testimonial testimonial) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      await ServiceLocator.submitTestimonial(testimonial);
      return true;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
