import 'package:flutter/material.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';

class DailyMottoCard extends StatelessWidget {
  const DailyMottoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.borderGold.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'GÜNÜN MOTTOSU',
                style: TextStyle(
                  color: AppColors.accentGold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '"Karakterin kaderindir, onu sabırla inşa et."',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        // Blur Efekti (Sağ üst köşe)
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(40),
              ),
            ),
            child: ClipRRect(
               borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(40),
              ),
              child: const SizedBox(), 
              // Gerçek blur filtre efekti performansı düşürebilir, 
              // bu yüzden opaklık ve gradient ile benzer hissiyatı veriyoruz.
            ),
          ),
        ),
      ],
    );
  }
}
