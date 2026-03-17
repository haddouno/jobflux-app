import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileListCard extends StatelessWidget {
  final Map<String, String> profile;
  const ProfileListCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.accentColor.withOpacity(0.15),
            child: Text(
              profile['name']![0],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.accentColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  profile['title']!,
                  style: const TextStyle(
                      fontSize: 12, color: AppTheme.grayText),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 12, color: AppTheme.grayText),
                    const SizedBox(width: 2),
                    Text(
                      profile['location']!,
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.grayText),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.star, size: 12, color: Color(0xFFFFAB00)),
                    const SizedBox(width: 2),
                    Text(
                      profile['rating']!,
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.grayText),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Contact button
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.accentColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
            ),
            child: const Text(
              'Contact',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
