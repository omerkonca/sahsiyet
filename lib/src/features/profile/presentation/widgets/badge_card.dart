import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class BadgeCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isLocked;

  const BadgeCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    // Opacity based on lock state
    final opacity = isLocked ? 0.6 : 1.0;
    
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLocked ? Colors.white.withOpacity(0.05) : AppColors.primary.withOpacity(0.2), 
            width: isLocked ? 1 : 1,
          ),
          boxShadow: isLocked ? [] : [
             BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
             ),
          ],
        ),
        child: Column(
          children: [
            if (isLocked)
              const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.lock, size: 16, color: Colors.white54),
              ),
            if (!isLocked) const SizedBox(height: 12), // Spacer for alignment if no lock
            
            // Icon Circle
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isLocked ? Colors.white.withOpacity(0.05) : AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isLocked ? Colors.white54 : AppColors.primary,
                size: 28,
              ),
            ),
            
            const Spacer(),
            
            // Text
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 1, // HTML also clamps line 1
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
