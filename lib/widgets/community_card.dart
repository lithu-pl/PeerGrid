import 'package:flutter/material.dart';
import '../models/community.dart';
import '../theme/app_theme.dart';

class CommunityCard extends StatelessWidget {
  final Community community;
  final VoidCallback onToggleJoin;

  const CommunityCard({
    super.key,
    required this.community,
    required this.onToggleJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          // Community Logo Icon Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: _buildCommunityIcon(community.iconCode),
            ),
          ),
          const SizedBox(width: 14),

          // Community Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '• ${community.memberCount} members',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  community.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Join Button
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: onToggleJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: community.isJoined
                    ? const Color(0xFFE2E8F0)
                    : AppTheme.primary,
                foregroundColor: community.isJoined
                    ? AppTheme.textSecondary
                    : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Text(
                community.isJoined ? 'Joined' : 'Join',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: community.isJoined
                      ? AppTheme.textSecondary
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityIcon(String iconCode) {
    IconData iconData;
    switch (iconCode) {
      case 'ieee':
        iconData = Icons.electrical_services_rounded;
        break;
      case 'tinkerhub':
        iconData = Icons.code_rounded;
        break;
      case 'edc':
        iconData = Icons.lightbulb_outline_rounded;
        break;
      default:
        iconData = Icons.groups_rounded;
    }
    return Icon(
      iconData,
      color: AppTheme.primaryDark,
      size: 26,
    );
  }
}
