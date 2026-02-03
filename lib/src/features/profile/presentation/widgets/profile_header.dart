import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.center,
          children: [
            // Glow Effect
            Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.6),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
            // Avatar
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.backgroundLight.withOpacity(0.1), // or backgroundDark based on user pref
                  width: 4,
                ),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAZJ9XyBJ0hRLn-2lgYJ_aRZ5VdAdjdFL0g5ZAi30vnRY6HYwCt4veUpWGz6uBUjP4o6URru_If5PUDJdgzBFCA_uBq2vUWI_osfsR62wfTaqL-wj4DDFW8KmOaLDix_2aJwS2m0C4mc6ZNkWB5FvYKtM5TyyYKVGCgTRbCpbZtsYDaMWLuW2Q4Sy-xsJEZNIjCjgt_DQuzXxV62SH4XmIuitywil2P2sYf_wNDOcJKSf7iatPjB_E74LDgN8LJpEk79DBrmnzMxQ'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                   ),
                ],
              ),
            ),
            // Edit Button
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.backgroundDark, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26, 
                      blurRadius: 4,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: AppColors.backgroundDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Ahmet Yılmaz',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: const Text(
                'MÜRİT',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Seviye 12',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
