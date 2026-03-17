import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';

enum NotifType { refused, accepted, info, profile }

class _NotifItem {
  final NotifType type;
  final String? name;
  final String? message;
  const _NotifItem({required this.type, this.name, this.message});
}

class NotificationsScreen extends StatelessWidget {
  final bool isEntrepreneur;
  const NotificationsScreen({super.key, required this.isEntrepreneur});

  static final List<_NotifItem> _notifications = [
    _NotifItem(
      type: NotifType.refused,
      message: "L'offre de (Graphic Designer) a été refusé par NOUREDDINE HADDOU",
    ),
    _NotifItem(
      type: NotifType.accepted,
      message: "L'offre de (QHSE Stage) a été acceptée par SARA BENALI",
    ),
    _NotifItem(
      type: NotifType.refused,
      message: "L'offre de (Delivery GIG) a été refusé par KARIM IDRISSI",
    ),
    _NotifItem(
      type: NotifType.info,
      message: "Votre offre (Web Dev) expire dans 3 jours. Renouvelez-la.",
    ),
    _NotifItem(
      type: NotifType.profile,
      name: 'NOUREDDINE HADDOU',
      message: 'Il a envoyé sa candidature en réponse à votre offre (stage/travail)',
    ),
    _NotifItem(
      type: NotifType.profile,
      name: 'FATIMA ZAHRA',
      message: 'Elle a envoyé sa candidature en réponse à votre offre (GIG livraison)',
    ),
    _NotifItem(
      type: NotifType.refused,
      message: "L'offre de (Developer) a été refusé par AHMED TAZI",
    ),
    _NotifItem(
      type: NotifType.accepted,
      message: "L'offre de (QHSE Animateur) a été acceptée par LAILA AMRANI",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(19, 12, 19, 20),
              itemCount: _notifications.length,
              itemBuilder: (ctx, i) =>
                  _buildNotifCard(_notifications[i], context),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        isEntrepreneur: isEntrepreneur,
        onTap: (i) {
          if (i == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(isEntrepreneur: isEntrepreneur),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppTheme.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 46,
        left: 19,
        right: 19,
        bottom: 12,
      ),
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
                ),
              ],
            ),
            child: const Icon(Icons.menu, size: 18, color: AppTheme.darkText),
          ),
          const SizedBox(width: 13),
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
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  hintStyle:
                      TextStyle(fontSize: 13, color: AppTheme.grayText),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Stack(
            children: [
              const Icon(Icons.notifications,
                  color: AppTheme.accentColor, size: 25),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotifCard(_NotifItem notif, BuildContext context) {
    if (notif.type == NotifType.profile) {
      return _buildProfileCard(notif);
    }
    return _buildSimpleNotifCard(notif);
  }

  Widget _buildSimpleNotifCard(_NotifItem notif) {
    Color bg, border, textColor;
    IconData icon;
    switch (notif.type) {
      case NotifType.accepted:
        bg = const Color(0xFFADFFEA);
        border = const Color(0xFF87DEC7);
        textColor = AppTheme.accentColor;
        icon = Icons.check_circle_outline;
        break;
      case NotifType.info:
        bg = const Color(0xFFFDFFCE);
        border = const Color(0xFFFFBB8B);
        textColor = const Color(0xFFFF9500);
        icon = Icons.info_outline;
        break;
      case NotifType.refused:
      default:
        bg = const Color(0xFFFFD3D3);
        border = const Color(0xFFFFA2A2);
        textColor = const Color(0xFFFF7C7C);
        icon = Icons.cancel_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      height: 77,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: border, width: 1.5),
            ),
            child: Icon(icon, color: textColor, size: 16),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              notif.message ?? '',
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(_NotifItem notif) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD3D3D3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 37,
            backgroundColor: AppTheme.accentColor.withOpacity(0.15),
            child: Text(
              notif.name?[0] ?? 'N',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.accentColor,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif.name ?? '',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.grayText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notif.message ?? '',
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.grayText, height: 1.3),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _ActionBtn(
                      label: 'Contact',
                      color: AppTheme.accentColor,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    _ActionBtn(
                      label: 'Refusé',
                      color: const Color(0xFFFF7C7C),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
