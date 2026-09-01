import 'package:flutter/material.dart';
import 'package:lactarehub/core/theme/app_colors.dart';
import 'package:lactarehub/core/theme/app_text_styles.dart';
import 'package:lactarehub/presentation/shared/components/lactare_logo.dart';

/// Tela de abertura: apresenta a marca e segue para a home pública.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.goToLanding});

  final VoidCallback goToLanding;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) widget.goToLanding();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgApp,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.86, end: 1).animate(_fade),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LactareLogo(size: 72, showWordmark: false),
                const SizedBox(height: 24),
                Text(
                  'Lactare',
                  style: AppTextStyles.heroTitle.copyWith(
                    color: AppColors.primary,
                    fontSize: 38,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Rede de bancos de leite humano',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(strokeWidth: 2.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
