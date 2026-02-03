import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class HistoryListItem extends StatelessWidget {
  final String date;
  final String subtitle;
  final bool isCompleted;

  const HistoryListItem({
    super.key,
    required this.date,
    required this.subtitle,
    this.isCompleted = true,
  });

  @override
  Widget build(BuildContext context) {
    final opacity = isCompleted ? 1.0 : 0.7;
    
    return Opacity(
      opacity: opacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? AppColors.primary.withOpacity(0.1) 
                    : Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.grade,
                color: isCompleted 
                    ? AppColors.primary 
                    : Colors.white.withOpacity(0.3),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isCompleted 
                          ? Colors.white 
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(isCompleted ? 0.4 : 0.3),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted 
                    ? Colors.green.withOpacity(0.2) 
                    : Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.remove,
                color: isCompleted 
                    ? Colors.green 
                    : Colors.white.withOpacity(0.2),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
