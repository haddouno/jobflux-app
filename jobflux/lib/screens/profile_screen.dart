import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isEntrepreneur;
  const ProfileScreen({super.key, required this.isEntrepreneur});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0; // 0=Education, 1=Experience, 2=Gigs
  final List<String> _tabs = ['Education', 'Expérience', 'Gigs'];

  final List<Map<String, dynamic>> _education = [
    {
      'title': 'Licence en Génie Civil',
      'school': 'Université Ibn Zohr - Agadir',
      'year': '2019 – 2022',
      'description': 'Formation en génie civil avec spécialisation en construction et topographie.',
      'skills': ['AutoCAD', 'BIM', 'Topographie', 'Béton', 'Structure', 'Excel'],
    },
    {
      'title': 'BTS Qualité HSE',
      'school': 'ISTA Agadir',
      'year': '2017 – 2019',
      'description': 'Formation professionnelle axée sur les normes qualité, santé, sécurité et environnement.',
      'skills': ['ISO 9001', 'ISO 45001', 'Audit', 'QHSE', 'Risque', 'Sécurité'],
    },
  ];

  final List<Map<String, dynamic>> _experience = [
    {
      'title': 'QHSE Animateur',
      'company': 'Groupe OCP - Benguerir',
      'period': 'Jan 2023 – Présent',
      'description': 'Animation des formations sécurité, gestion des incidents et audits internes.',
    },
    {
      'title': 'Stagiaire QHSE',
      'company': 'Lafarge Holcim Maroc',
      'period': 'Juin 2022 – Déc 2022',
      'description': 'Support à l\'implémentation du système de management HSE.',
    },
  ];

  final List<Map<String, dynamic>> _gigs = [
    {
      'title': 'Formation Sécurité au Travail',
      'price': '500 MAD',
      'duration': '1 journée',
      'description': 'Formation pratique sur les règles de sécurité en milieu industriel.',
    },
    {
      'title': 'Audit QHSE Interne',
      'price': '800 MAD',
      'duration': '2 jours',
      'description': 'Réalisation d\'un audit QHSE complet avec rapport détaillé.',
    },
    {
      'title': 'Rédaction Plan de Prévention',
      'price': '300 MAD',
      'duration': '3 jours',
      'description': 'Rédaction et mise en place d\'un plan de prévention des risques.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildBanner()),
          SliverToBoxAdapter(child: _buildProfileHeader()),
          SliverToBoxAdapter(child: _buildNameRatingRow()),
          SliverToBoxAdapter(child: _buildAbout()),
          SliverToBoxAdapter(child: _buildTabBar()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _buildTabContent(i),
                childCount: _currentList.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        isEntrepreneur: widget.isEntrepreneur,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HomeScreen(isEntrepreneur: widget.isEntrepreneur),
              ),
            );
          }
        },
      ),
    );
  }

  List<Map<String, dynamic>> get _currentList {
    if (_selectedTab == 0) return _education;
    if (_selectedTab == 1) return _experience;
    return _gigs;
  }

  Widget _buildBanner() {
    return Stack(
      children: [
        // Status bar background
        Container(
          height: MediaQuery.of(context).padding.top + 35,
          color: AppTheme.white,
        ),
        // Header row with search
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 20,
          right: 20,
          child: Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: const Icon(Icons.menu, size: 18, color: AppTheme.darkText),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 37,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: AppTheme.grayText),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.notifications_outlined,
                  color: AppTheme.darkText, size: 25),
            ],
          ),
        ),
        // Profile banner image
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
          child: Container(
            height: 139,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1DCD9F), Color(0xFF0A8A6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'JOB FLUX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar circle
          Container(
            width: 119,
            height: 119,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.white, width: 4),
              color: AppTheme.accentColor.withOpacity(0.15),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                'N',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.accentColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'NOUREDDINE HADDOU',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameRatingRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ANIMATER QHSE',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < 4 ? Icons.star : Icons.star_half,
                      color: const Color(0xFFFFAB00),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Contact me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppTheme.grayText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Professional QHSE Animator with over 3 years of experience in industrial safety, quality management and environmental compliance. Passionate about creating safer workplaces.',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.grayText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final active = _selectedTab == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: active
                          ? AppTheme.accentColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: active ? AppTheme.accentColor : AppTheme.grayText,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    final item = _currentList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF87DEC7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + year/period
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF87DEC7),
                      ),
                    ),
                    Text(
                      (item['school'] ?? item['company'] ?? '') as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF87DEC7),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                (item['year'] ?? item['period'] ?? item['duration'] ?? '') as String,
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.grayText),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Description label
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.grayText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item['description'] as String,
            style: const TextStyle(
                fontSize: 14, color: AppTheme.grayText, height: 1.4),
          ),
          // Skills tags (education only)
          if (item.containsKey('skills')) ...[
            const SizedBox(height: 10),
            const Text(
              'SKILLS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.grayText,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: (item['skills'] as List<String>)
                  .map(
                    (s) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.grayText),
                      ),
                      child: Text(
                        s,
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.grayText),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          // Price for gigs
          if (item.containsKey('price')) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item['price'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.accentColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    minimumSize: const Size(80, 28),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                  ),
                  child: const Text(
                    'Commander',
                    style: TextStyle(
                        fontSize: 11, color: AppTheme.accentColor),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
