import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OnboardingScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
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
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          // Bottom teal glow
          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 520,
              height: 520,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.accentColor.withOpacity(0.35),
              ),
            ),
          ),
          // Logo centered
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: _JobFluxLogo(size: 130),
            ),
          ),
        ],
      ),
    );
  }
}

class _JobFluxLogo extends StatelessWidget {
  final double size;
  const _JobFluxLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.75,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: size * 0.34,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.darkText,
                  letterSpacing: -1,
                ),
                children: [
                  const TextSpan(text: 'J'),
                  WidgetSpan(
                    child: Container(
                      width: size * 0.20,
                      height: size * 0.20,
                      margin: EdgeInsets.only(bottom: size * 0.04),
                      decoration: const BoxDecoration(
                        color: AppTheme.accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.search,
                        color: AppTheme.darkText,
                        size: size * 0.13,
                      ),
                    ),
                  ),
                  const TextSpan(text: 'b'),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              'flux',
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w900,
                color: AppTheme.darkText,
                letterSpacing: -1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
