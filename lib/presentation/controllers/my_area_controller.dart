import 'package:flutter/foundation.dart';
import 'package:lactarehub/core/di/service_locator.dart';
import 'package:lactarehub/domain/entities/achievement.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_schedule.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/domain/entities/donor.dart';

/// Estado da área da doadora.
class MyAreaController extends ChangeNotifier {
  Donor? _donor;
  CollectionSchedule? _schedule;
  Donation? _currentDonation;
  List<Achievement> _achievements = const [];
  List<Article> _readings = const [];
  bool _isLoading = true;

  Donor? get donor => _donor;
  List<Achievement> get achievements => _achievements;

  /// Nula quando não há coleta marcada.
  CollectionSchedule? get schedule => _schedule;

  /// Nula enquanto a pessoa não tiver nenhuma doação a rastrear.
  Donation? get currentDonation => _currentDonation;
  List<Article> get readings => _readings;
  bool get isLoading => _isLoading;

  /// Primeira carga: mostra o indicador enquanto busca.
  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    await _fetch();
    _isLoading = false;
    notifyListeners();
  }

  /// Revalidação silenciosa, usada quando a aba volta a ficar visível.
  Future<void> refresh() async {
    await _fetch();
    notifyListeners();
  }

  Future<void> _fetch() async {
    _donor = await ServiceLocator.getDonorProfile();
    _schedule = await ServiceLocator.getNextCollection();
    _currentDonation = await ServiceLocator.getCurrentDonation();
    _achievements = await ServiceLocator.getAchievements();
    _readings = await ServiceLocator.listFeaturedArticles();
  }
}
