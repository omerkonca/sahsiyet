import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/dashboard/domain/task_model.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Kilitli durumu kontrolü ve stil
    final isLocked = task.isLocked;
    final isCompleted = task.isCompleted;

    final bgColor = isLocked ? AppColors.cardDark.withOpacity(0.4) : AppColors.cardDark;
    
    // İkon belirleme (Modelden gelen tipe göre veya sabit ikonlar atanabilir, şimdilik sabit)
    IconData getIcon() {
      if (task.title.contains('selam')) return LucideIcons.heartHandshake;
      if (task.title.contains('engel')) return LucideIcons.mountainSnow;
      return LucideIcons.lock; 
    }

    final icon = getIcon();

    final iconColor = isLocked 
        ? Colors.white.withOpacity(0.3) 
        : (isCompleted ? AppColors.backgroundDark : AppColors.primary);
        
    final iconBgColor = isLocked 
        ? Colors.white.withOpacity(0.05) 
        : (isCompleted ? AppColors.primary : Colors.white.withOpacity(0.05));

    return GestureDetector(
      onTap: isLocked ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLocked 
              ? Colors.white.withOpacity(0.05) 
              : (isCompleted ? AppColors.primary : AppColors.borderGold.withOpacity(0.2)),
            width: isCompleted ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.primary : Colors.white.withOpacity(0.1),
                ),
                boxShadow: isCompleted 
                  ? [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 8, spreadRadius: 1)] 
                  : [],
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      color: isLocked ? Colors.white.withOpacity(0.6) : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(isLocked ? 0.3 : 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Checkbox/Action Button
             if (!isLocked)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? AppColors.primary : Colors.transparent,
                  border: Border.all(
                    color: isCompleted ? AppColors.primary : Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: isCompleted 
                    ? const Icon(Icons.check, key: ValueKey('check'), size: 16, color: AppColors.backgroundDark) 
                    : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ),
            if (isLocked)
               const Icon(Icons.lock, size: 16, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
