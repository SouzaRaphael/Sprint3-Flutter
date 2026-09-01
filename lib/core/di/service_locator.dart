import 'package:lactarehub/data/repositories/article_repository_impl.dart';
import 'package:lactarehub/data/repositories/auth_repository_impl.dart';
import 'package:lactarehub/data/repositories/collection_point_repository_impl.dart';
import 'package:lactarehub/data/repositories/donation_repository_impl.dart';
import 'package:lactarehub/data/repositories/donor_repository_impl.dart';
import 'package:lactarehub/data/repositories/institutional_repository_impl.dart';
import 'package:lactarehub/data/repositories/schedule_repository_impl.dart';
import 'package:lactarehub/data/repositories/testimonial_repository_impl.dart';
import 'package:lactarehub/domain/usecases/auth/get_test_credentials.dart';
import 'package:lactarehub/domain/usecases/auth/register_donor.dart';
import 'package:lactarehub/domain/usecases/auth/sign_in.dart';
import 'package:lactarehub/domain/usecases/content/list_articles.dart';
import 'package:lactarehub/domain/usecases/content/list_featured_articles.dart';
import 'package:lactarehub/domain/usecases/donation/get_current_donation.dart';
import 'package:lactarehub/domain/usecases/donation/list_donations.dart';
import 'package:lactarehub/domain/usecases/donor/get_achievements.dart';
import 'package:lactarehub/domain/usecases/donor/get_donor_profile.dart';
import 'package:lactarehub/domain/usecases/institutional/get_impact_stats.dart';
import 'package:lactarehub/domain/usecases/institutional/list_how_it_works_steps.dart';
import 'package:lactarehub/domain/usecases/points/list_collection_points.dart';
import 'package:lactarehub/domain/usecases/schedule/confirm_collection.dart';
import 'package:lactarehub/domain/usecases/schedule/get_available_windows.dart';
import 'package:lactarehub/domain/usecases/schedule/get_next_collection.dart';
import 'package:lactarehub/domain/usecases/schedule/schedule_collection.dart';
import 'package:lactarehub/domain/usecases/testimonials/list_testimonials.dart';
import 'package:lactarehub/domain/usecases/testimonials/submit_testimonial.dart';

/// Único ponto do aplicativo em que a camada de apresentação encosta nas
/// implementações concretas de `data`.
///
/// As telas recebem apenas casos de uso, o que mantém a dependência apontando
/// sempre para o domínio. Registro manual — sem pacote de injeção.
abstract class ServiceLocator {
  static late final SignIn signIn;
  static late final RegisterDonor registerDonor;
  static late final GetTestCredentials getTestCredentials;

  static late final GetDonorProfile getDonorProfile;
  static late final GetAchievements getAchievements;

  static late final ListDonations listDonations;
  static late final GetCurrentDonation getCurrentDonation;

  static late final GetNextCollection getNextCollection;
  static late final ConfirmCollection confirmCollection;
  static late final ScheduleCollection scheduleCollection;
  static late final GetAvailableWindows getAvailableWindows;

  static late final ListCollectionPoints listCollectionPoints;

  static late final ListArticles listArticles;
  static late final ListFeaturedArticles listFeaturedArticles;

  static late final ListTestimonials listTestimonials;
  static late final SubmitTestimonial submitTestimonial;

  static late final GetImpactStats getImpactStats;
  static late final ListHowItWorksSteps listHowItWorksSteps;

  static bool _initialized = false;

  /// Monta o grafo de dependências. Chamado uma única vez em `main`.
  static void setUp() {
    if (_initialized) return;
    _initialized = true;

    final authRepository = AuthRepositoryImpl();
    final donorRepository = DonorRepositoryImpl();
    final donationRepository = DonationRepositoryImpl();
    final scheduleRepository = ScheduleRepositoryImpl();
    final pointRepository = CollectionPointRepositoryImpl();
    final articleRepository = ArticleRepositoryImpl();
    final testimonialRepository = TestimonialRepositoryImpl();
    final institutionalRepository = InstitutionalRepositoryImpl();

    signIn = SignIn(authRepository);
    registerDonor = RegisterDonor(authRepository);
    getTestCredentials = GetTestCredentials(authRepository);

    getDonorProfile = GetDonorProfile(donorRepository);
    getAchievements = GetAchievements(donorRepository);

    listDonations = ListDonations(donationRepository);
    getCurrentDonation = GetCurrentDonation(donationRepository);

    getNextCollection = GetNextCollection(scheduleRepository);
    confirmCollection = ConfirmCollection(scheduleRepository);
    scheduleCollection = ScheduleCollection(scheduleRepository);
    getAvailableWindows = GetAvailableWindows(scheduleRepository);

    listCollectionPoints = ListCollectionPoints(pointRepository);

    listArticles = ListArticles(articleRepository);
    listFeaturedArticles = ListFeaturedArticles(articleRepository);

    listTestimonials = ListTestimonials(testimonialRepository);
    submitTestimonial = SubmitTestimonial(testimonialRepository);

    getImpactStats = GetImpactStats(institutionalRepository);
    listHowItWorksSteps = ListHowItWorksSteps(institutionalRepository);
  }
}
