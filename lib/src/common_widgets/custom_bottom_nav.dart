import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24, top: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(0.95),
        border: const Border(
          top: BorderSide(color: Color(0x0DFFFFFF)), // white/5
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_filled,
              label: 'Ana Sayfa',
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.menu_book_rounded, // Moved Library here
              label: 'Kütüphane',
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _CenterActionButton(onTap: () => onTap(2)),
            _NavItem(
              icon: Icons.bar_chart_rounded, // Progress
              label: 'Gelişim',
              isSelected: currentIndex == 3,
              onTap: () => onTap(3),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'Profil',
              isSelected: currentIndex == 4,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.4),
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterActionButton extends StatelessWidget {
  final VoidCallback onTap;
  
  const _CenterActionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform.translate(
        offset: const Offset(0, -24), 
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Icon(
            Icons.auto_awesome, // Updated to Stars/Sparkles icon as per user request
            color: AppColors.backgroundDark, // Dark icon
            size: 32,
          ),
        ),
      ),
    );
  }
}
