import 'package:flutter/material.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/screens/auth/login_screen.dart';
import 'package:lactarehub/presentation/screens/content/article_detail_screen.dart';
import 'package:lactarehub/presentation/screens/donation/donation_detail_screen.dart';
import 'package:lactarehub/presentation/screens/landing/landing_screen.dart';
import 'package:lactarehub/presentation/screens/points/collection_point_detail_screen.dart';
import 'package:lactarehub/presentation/screens/registration/registration_screen.dart';
import 'package:lactarehub/presentation/screens/registration/registration_success_screen.dart';
import 'package:lactarehub/presentation/screens/shell/main_shell_screen.dart';
import 'package:lactarehub/presentation/screens/shell/shell_tab.dart';
import 'package:lactarehub/presentation/screens/splash/splash_screen.dart';
import 'package:lactarehub/presentation/screens/testimonials/testimonials_screen.dart';
import 'package:lactarehub/presentation/screens/testimonials/write_testimonial_screen.dart';

part 'app_routes.dart';

/// Roteamento central do aplicativo.
///
/// Cada tela recebe apenas callbacks de navegação, o que a mantém ignorante
/// sobre o `Navigator` e fácil de testar isoladamente. As telas de detalhe
/// recebem a entidade correspondente por `settings.arguments`.
abstract class AppNavigation {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _route(
          settings,
          (context) => SplashScreen(
            goToLanding: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.landing),
          ),
        );

      case AppRoutes.landing:
        return _route(
          settings,
          (context) => LandingScreen(
            onStartDonation: () =>
                Navigator.pushNamed(context, AppRoutes.registration),
            onLogin: () => Navigator.pushNamed(context, AppRoutes.login),
            onOpenMap: () => _openApp(context, ShellTab.pontos),
            onOpenContent: () => _openApp(context, ShellTab.conteudo),
            onOpenTestimonials: () =>
                Navigator.pushNamed(context, AppRoutes.testimonials),
          ),
        );

      case AppRoutes.login:
        return _route(
          settings,
          (context) => LoginScreen(
            onSignedIn: () => _openApp(context, ShellTab.inicio),
            onRegister: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.registration),
            goBack: () => Navigator.pop(context),
          ),
        );

      case AppRoutes.registration:
        return _route(
          settings,
          (context) => RegistrationScreen(
            onCompleted: () => Navigator.pushReplacementNamed(
              context,
              AppRoutes.registrationSuccess,
            ),
            goBack: () => Navigator.pop(context),
          ),
        );

      case AppRoutes.registrationSuccess:
        return _route(
          settings,
          (context) => RegistrationSuccessScreen(
            onEnterApp: () => _openApp(context, ShellTab.inicio),
          ),
        );

      case AppRoutes.app:
        final tab = settings.arguments as ShellTab? ?? ShellTab.inicio;
        return _route(
          settings,
          (context) => MainShellScreen(
            initialTab: tab,
            onOpenTestimonials: () =>
                Navigator.pushNamed(context, AppRoutes.testimonials),
            onOpenArticle: (article) => Navigator.pushNamed(
              context,
              AppRoutes.articleDetail,
              arguments: article,
            ),
            onOpenCollectionPoint: (point) => Navigator.pushNamed(
              context,
              AppRoutes.collectionPointDetail,
              arguments: point,
            ),
            onOpenDonation: (donation) => Navigator.pushNamed(
              context,
              AppRoutes.donationDetail,
              arguments: donation,
            ),
          ),
        );

      case AppRoutes.testimonials:
        return _route(
          settings,
          (context) => TestimonialsScreen(
            goBack: () => Navigator.pop(context),
            onWriteTestimonial: () async {
              await Navigator.pushNamed(context, AppRoutes.writeTestimonial);
            },
          ),
        );

      case AppRoutes.writeTestimonial:
        return _route(
          settings,
          (context) =>
              WriteTestimonialScreen(goBack: () => Navigator.pop(context)),
        );

      case AppRoutes.articleDetail:
        final article = settings.arguments as Article;
        return _route(
          settings,
          (context) => ArticleDetailScreen(
            article: article,
            goBack: () => Navigator.pop(context),
          ),
        );

      case AppRoutes.collectionPointDetail:
        final point = settings.arguments as CollectionPoint;
        return _route(
          settings,
          (context) => CollectionPointDetailScreen(
            point: point,
            goBack: () => Navigator.pop(context),
          ),
        );

      case AppRoutes.donationDetail:
        final donation = settings.arguments as Donation;
        return _route(
          settings,
          (context) => DonationDetailScreen(
            donation: donation,
            goBack: () => Navigator.pop(context),
          ),
        );

      default:
        return _route(
          settings,
          (context) => const Scaffold(
            body: Center(child: Text('Tela não encontrada.')),
          ),
        );
    }
  }

  /// Abre a casca autenticada já na aba pedida, limpando a pilha pública.
  static void _openApp(BuildContext context, ShellTab tab) =>
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.app,
        (route) => route.settings.name == AppRoutes.landing,
        arguments: tab,
      );

  static MaterialPageRoute<dynamic> _route(
    RouteSettings settings,
    WidgetBuilder builder,
  ) => MaterialPageRoute<dynamic>(settings: settings, builder: builder);
}
