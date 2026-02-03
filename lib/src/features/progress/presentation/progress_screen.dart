import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/common_widgets/animations/entrance_fader.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/progress/presentation/controllers/progress_controller.dart';
import 'package:sahsiyet/src/features/progress/presentation/widgets/history_list_item.dart';
import 'package:sahsiyet/src/features/progress/presentation/widgets/performance_card.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);

    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          children: [
            const SizedBox(height: 48),
            EntranceFader(
              delay: const Duration(milliseconds: 100),
              child: PerformanceCard(
                progress: progressState.weeklyStability,
                streak: progressState.currentStreak,
                totalPoints: progressState.totalPoints,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Geçmiş',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Tümünü Gör'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const HistoryListItem(
              date: 'Pazartesi, 14 Ekim',
              subtitle: '5 Görev Tamamlandı',
              isCompleted: true,
            ),
            const HistoryListItem(
              date: 'Pazar, 13 Ekim',
              subtitle: '4 Görev Tamamlandı',
              isCompleted: true,
            ),
            const HistoryListItem(
              date: 'Cumartesi, 12 Ekim',
              subtitle: '6 Görev Tamamlandı',
              isCompleted: true,
            ),
            const HistoryListItem(
              date: 'Cuma, 11 Ekim',
              subtitle: 'Dinlenme Günü',
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }
}
