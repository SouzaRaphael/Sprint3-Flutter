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
  List<Article> get featuredArticles => _featuredArticles;
  bool get isLoading => _isLoading;
  bool get isConfirming => _isConfirming;

  /// Nula quando não há coleta marcada.
  CollectionSchedule? get schedule => _schedule;

  /// Nula enquanto a pessoa não tiver nenhuma doação em trânsito.
  Donation? get currentDonation => _currentDonation;

  /// Primeira carga: mostra o indicador enquanto busca.
  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    await _fetch();
    _isLoading = false;
    notifyListeners();
  }

  /// Revalidação silenciosa, usada quando a aba volta a ficar visível.
  ///
  /// Mantém o conteúdo atual na tela em vez de piscar um indicador a cada
  /// troca de aba — e é o que faz uma coleta agendada em outra aba aparecer
  /// aqui imediatamente.
  Future<void> refresh() async {
    await _fetch();
    notifyListeners();
  }

  Future<void> _fetch() async {
    _donor = await ServiceLocator.getDonorProfile();
    _schedule = await ServiceLocator.getNextCollection();
    _currentDonation = await ServiceLocator.getCurrentDonation();
    _featuredArticles = await ServiceLocator.listFeaturedArticles();
  }

  /// Confirma a coleta agendada e devolve o estado atualizado.
  Future<void> confirmCollection() async {
    if (_schedule == null) return;

    _isConfirming = true;
    notifyListeners();

    _schedule = await ServiceLocator.confirmCollection();

    _isConfirming = false;
    notifyListeners();
  }
}
