import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class LibraryItemCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const LibraryItemCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26, 
              blurRadius: 4, 
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'library_icon_$id',
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  // color: AppColors.primary.withOpacity(0.1), 
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.primary.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
