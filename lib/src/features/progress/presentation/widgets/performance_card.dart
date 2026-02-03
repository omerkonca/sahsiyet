import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class PerformanceCard extends StatelessWidget {
  final double progress;
  final int streak;
  final int totalPoints;

  const PerformanceCard({
    super.key,
    required this.progress,
    required this.streak,
    required this.totalPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark, // Using theme card color (#2D281A) resembling #2c2818
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Progress Section (Mobile layout column)
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center for now, or start
            children: [
              // Chart
              Column(
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background Circle
                        CircularProgressIndicator(
                          value: 1.0,
                          strokeWidth: 8,
                          color: Colors.white.withOpacity(0.05),
                        ),
                        // Progress Circle
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: progress),
                          duration: const Duration(seconds: 1),
                          builder: (context, value, _) => CircularProgressIndicator(
                            value: value,
                            strokeWidth: 8,
                            color: AppColors.primary,
                            strokeCap: StrokeCap.round,
                          ),
                        ),
                        // Text Center
                        Center(
                          child: Text(
                            '%${(progress * 100).toInt()}',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Genel Tamamlanma',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.local_fire_department,
                  label: 'Mevcut Zincir',
                  value: '$streak Gün',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatItem(
                  icon: Icons.workspace_premium,
                  label: 'Toplam Puan',
                  value: '$totalPoints',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF36311E), // Slightly lighter/different tone from HTML dark theme
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
