import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Estado da home da doadora.
class DonorHomeController extends ChangeNotifier {
  Donor? _donor;
  CollectionSchedule? _schedule;
  Donation? _currentDonation;
  List<Article> _featuredArticles = const [];
  bool _isLoading = true;
  bool _isConfirming = false;

  Donor? get donor => _donor;
  CollectionSchedule? get schedule => _schedule;
  Donation? get currentDonation => _currentDonation;
  List<Article> get featuredArticles => _featuredArticles;
  bool get isLoading => _isLoading;
  bool get isConfirming => _isConfirming;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _donor = await ServiceLocator.getDonorProfile();
    _schedule = await ServiceLocator.getNextCollection();
    _currentDonation = await ServiceLocator.getCurrentDonation();
    _featuredArticles = await ServiceLocator.listFeaturedArticles();

    _isLoading = false;
    notifyListeners();
  }

  /// Confirma a coleta agendada e devolve o estado atualizado.
  Future<void> confirmCollection() async {
    _isConfirming = true;
    notifyListeners();

    _schedule = await ServiceLocator.confirmCollection();

    _isConfirming = false;
    notifyListeners();
  }

  /// Reexibe os dados da agenda depois de um agendamento em outra aba.
  Future<void> refreshSchedule() async {
    _schedule = await ServiceLocator.getNextCollection();
    notifyListeners();
  }
}
