import 'package:flutter/material.dart';
import 'package:lactarehub/domain/entities/article.dart';
import 'package:lactarehub/domain/entities/collection_point.dart';
import 'package:lactarehub/domain/entities/donation.dart';
import 'package:lactarehub/presentation/screens/content/content_screen.dart';
import 'package:lactarehub/presentation/screens/donor_home/donor_home_screen.dart';
import 'package:lactarehub/presentation/screens/my_area/my_area_screen.dart';
import 'package:lactarehub/presentation/screens/points/collection_points_screen.dart';
import 'package:lactarehub/presentation/screens/schedule/schedule_collection_screen.dart';
import 'package:lactarehub/presentation/screens/shell/shell_tab.dart';
import 'package:lactarehub/presentation/shared/components/app_bottom_nav.dart';

/// Casca autenticada: mantém as cinco abas e a barra de navegação inferior.
///
/// Usa [IndexedStack] para que cada aba conserve rolagem e filtros ao ir e
/// voltar — o mesmo comportamento do protótipo navegado.
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({
    super.key,
    required this.initialTab,
    required this.onOpenTestimonials,
    required this.onOpenArticle,
    required this.onOpenCollectionPoint,
    required this.onOpenDonation,
  });

  final ShellTab initialTab;
  final VoidCallback onOpenTestimonials;
  final ValueChanged<Article> onOpenArticle;
  final ValueChanged<CollectionPoint> onOpenCollectionPoint;
  final ValueChanged<Donation> onOpenDonation;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late ShellTab _currentTab = widget.initialTab;

  static const List<BottomNavItem> _navItems = [
    BottomNavItem(icon: Icons.home_outlined, label: 'Início'),
    BottomNavItem(icon: Icons.favorite_border, label: 'Doar'),
    BottomNavItem(icon: Icons.location_on_outlined, label: 'Pontos'),
    BottomNavItem(icon: Icons.menu_book_outlined, label: 'Conteúdo'),
    BottomNavItem(icon: Icons.person_outline, label: 'Eu'),
  ];

  void _goToTab(ShellTab tab) => setState(() => _currentTab = tab);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          DonorHomeScreen(
            onOpenSchedule: () => _goToTab(ShellTab.doar),
            onOpenPoints: () => _goToTab(ShellTab.pontos),
            onOpenContent: () => _goToTab(ShellTab.conteudo),
            onOpenTestimonials: widget.onOpenTestimonials,
            onOpenMyArea: () => _goToTab(ShellTab.eu),
            onOpenArticle: widget.onOpenArticle,
            onOpenDonation: widget.onOpenDonation,
          ),
          ScheduleCollectionScreen(onScheduled: () => _goToTab(ShellTab.inicio)),
          CollectionPointsScreen(onOpenPoint: widget.onOpenCollectionPoint),
          ContentScreen(onOpenArticle: widget.onOpenArticle),
          MyAreaScreen(
            onOpenSchedule: () => _goToTab(ShellTab.doar),
            onOpenArticle: widget.onOpenArticle,
            onOpenDonation: widget.onOpenDonation,
            onOpenTestimonials: widget.onOpenTestimonials,
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        items: _navItems,
        currentIndex: _currentTab.index,
        onSelected: (index) => _goToTab(ShellTab.values[index]),
      ),
    );
  }
}
