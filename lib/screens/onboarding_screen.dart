import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      title: 'Welcome',
      subtitle:
          'Si vous êtes perdu dans le labyrinthe de stage ou bricole, Voici Job Flux — pour vous faciliter la tâche. En un clic, des opportunités de travail, d\'apprentissage et d\'acquisition d\'expérience s\'offrent à vous.',
      showButtons: false,
    ),
    _OnboardingPage(
      title: 'Welcome',
      subtitle: 'Trouvez vous-même ce dont vous avez besoin',
      showButtons: false,
    ),
    _OnboardingPage(
      title: '',
      subtitle: '',
      showButtons: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemCount: _pages.length,
        itemBuilder: (ctx, i) {
          final page = _pages[i];
          return _buildPageContent(page, i);
        },
      ),
    );
  }

  Widget _buildPageContent(_OnboardingPage page, int index) {
    return Stack(
      children: [
        // Teal ellipse background (top-left for page 0, top-right for page 1, etc.)
        Positioned(
          top: index == 1
              ? -100
              : index == 2
                  ? -200
                  : -50,
          right: index == 1 ? -200 : null,
          left: index == 0 ? -100 : null,
          child: Container(
            width: 700,
            height: 700,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentColor.withOpacity(index == 2 ? 0.9 : 0.4),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Logo top center
              _buildLogoSmall(),
              const Spacer(),
              // Content
              if (page.showButtons)
                _buildRoleSelection()
              else
                _buildTextContent(page),
              const SizedBox(height: 40),
              // Dots + nav
              _buildNavigation(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSmall() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 99,
        height: 74,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                  children: [
                    TextSpan(text: 'J'),
                    WidgetSpan(
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.search,
                          color: AppTheme.accentColor,
                          size: 14,
                        ),
                      ),
                    ),
                    TextSpan(text: 'b'),
                  ],
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              child: Text(
                'flux',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextContent(_OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: AppTheme.mediumText,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.grayText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 85),
      child: Column(
        children: [
          _RoleButton(
            icon: Icons.business,
            label: 'Entrepreneur',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignupScreen(isEntrepreneur: true),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _RoleButton(
            icon: Icons.school,
            label: 'Stagiaire',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignupScreen(isEntrepreneur: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 42),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back arrow
          if (_currentPage > 0)
            GestureDetector(
              onTap: _prevPage,
              child: Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.accentColor, width: 1.5),
                ),
                child: const Icon(Icons.arrow_back,
                    color: AppTheme.accentColor, size: 22),
              ),
            )
          else
            const SizedBox(width: 57),

          // Page dots
          Row(
            children: List.generate(
              _pages.length,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _currentPage
                      ? AppTheme.accentColor
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),

          // Next arrow
          if (_currentPage < _pages.length - 1)
            GestureDetector(
              onTap: _nextPage,
              child: Container(
                width: 57,
                height: 57,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentColor,
                ),
                child: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 22),
              ),
            )
          else
            const SizedBox(width: 57),
        ],
      ),
    );
  }
}

class _OnboardingPage {
  final String title;
  final String subtitle;
  final bool showButtons;
  _OnboardingPage(
      {required this.title,
      required this.subtitle,
      required this.showButtons});
}

class _RoleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _RoleButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 190,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: AppTheme.accentColor, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.accentColor, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
