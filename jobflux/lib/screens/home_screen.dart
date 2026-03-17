import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/job_card.dart';
import '../widgets/profile_card.dart';
import '../widgets/bottom_nav_bar.dart';
import 'add_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isEntrepreneur;
  const HomeScreen({super.key, required this.isEntrepreneur});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  String _selectedFilter = 'GIG';
  bool _showFilter = false;

  final List<Map<String, String>> _mockJobs = [
    {
      'title': 'Full-Stack Developer Needed',
      'company': 'TechCorp Maroc',
      'location': 'Casablanca',
      'type': 'WORK',
      'salary': '4000–8000 MAD/mois',
      'description':
          'We are looking for a skilled Full-Stack Developer to build and maintain a web application.',
    },
    {
      'title': 'QHSE Intern',
      'company': 'Industrie Maroc',
      'location': 'Agadir',
      'type': 'STAGE',
      'salary': '1000–2000 MAD/mois',
      'description':
          'QHSE Intern to support the implementation of Quality, Health, Safety, and Environmental systems.',
    },
    {
      'title': 'Need a Student Delivery Person',
      'company': 'Self-employed',
      'location': 'Agadir',
      'type': 'GIG',
      'salary': '20 MAD per delivery',
      'description':
          'Looking for a reliable student to handle deliveries of food, groceries, and small packages.',
    },
    {
      'title': 'Graphic Designer',
      'company': 'Creative Studio',
      'location': 'Rabat',
      'type': 'GIG',
      'salary': '300–600 MAD/projet',
      'description': 'Graphic designer for social media posts and brand identity.',
    },
    {
      'title': 'Web Development Internship',
      'company': 'StartupHub',
      'location': 'Marrakech',
      'type': 'STAGE',
      'salary': '1500 MAD/mois',
      'description': 'Join our team to work on real web development projects.',
    },
  ];

  final List<Map<String, String>> _mockProfiles = [
    {
      'name': 'Noureddine Haddou',
      'title': 'QHSE Engineer',
      'location': 'Agadir',
      'rating': '4.5',
      'category': 'videographe',
    },
    {
      'name': 'Sara Benali',
      'title': 'Frontend Developer',
      'location': 'Casablanca',
      'rating': '4.0',
      'category': 'dev',
    },
    {
      'name': 'Karim Idrissi',
      'title': 'Graphic Designer',
      'location': 'Rabat',
      'rating': '5.0',
      'category': 'designe',
    },
    {
      'name': 'Fatima Zahra',
      'title': 'Copywriter',
      'location': 'Fes',
      'rating': '3.5',
      'category': 'copywraiting',
    },
  ];

  List<Map<String, String>> get _filteredJobs {
    if (_selectedFilter == 'ALL') return _mockJobs;
    return _mockJobs
        .where((j) => j['type'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBg,
      body: _buildBody(),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedTab,
        isEntrepreneur: widget.isEntrepreneur,
        onTap: (i) {
          if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddScreen(isEntrepreneur: widget.isEntrepreneur),
              ),
            );
          } else if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(isEntrepreneur: widget.isEntrepreneur),
              ),
            );
          } else {
            setState(() => _selectedTab = i);
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        _buildFilterRow(),
        Expanded(
          child: widget.isEntrepreneur ? _buildProfileList() : _buildJobList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 20,
        right: 20,
        bottom: 12,
      ),
      child: Row(
        children: [
          // Menu icon / logo placeholder
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: AppTheme.accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.grid_view_rounded,
                color: AppTheme.accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Search bar
          Expanded(
            child: Container(
              height: 37,
              decoration: BoxDecoration(
                color: AppTheme.lightBg,
                borderRadius: BorderRadius.circular(18),
              ),
              child: TextField(
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search jobs, gigs, internships...',
                  hintStyle: const TextStyle(
                      fontSize: 12, color: AppTheme.grayText),
                  prefixIcon: const Icon(Icons.search,
                      color: AppTheme.grayText, size: 18),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Bell
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NotificationsScreen(
                    isEntrepreneur: widget.isEntrepreneur),
              ),
            ),
            child: const Icon(Icons.notifications_outlined,
                color: AppTheme.darkText, size: 25),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Container(
      color: AppTheme.white,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['ALL', 'GIG', 'STAGE', 'WORK'].map((f) {
                  final sel = _selectedFilter == f;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = f),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        color: sel ? AppTheme.accentColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: sel
                              ? AppTheme.accentColor
                              : AppTheme.borderColor,
                        ),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: sel ? Colors.white : AppTheme.grayText,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => _showFilter = !_showFilter),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _showFilter
                    ? AppTheme.accentColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: const Icon(Icons.tune, size: 18, color: AppTheme.darkText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobList() {
    final jobs = _filteredJobs;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      itemCount: jobs.length,
      itemBuilder: (ctx, i) => JobCard(job: jobs[i]),
    );
  }

  Widget _buildProfileList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      itemCount: _mockProfiles.length,
      itemBuilder: (ctx, i) => ProfileListCard(profile: _mockProfiles[i]),
    );
  }
}
