import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/common_widgets/animations/entrance_fader.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/controllers/task_controller.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/widgets/daily_motto_card.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/widgets/daily_wisdom_card.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/widgets/next_prayer_card.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/widgets/task_list_item.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    final tasks = ref.watch(taskControllerProvider);
    final activeTaskCount = tasks.where((t) => !t.isCompleted && !t.isLocked).length;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),
                  
                  // Header
                  EntranceFader(
                    delay: const Duration(milliseconds: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dashboardState.formattedDate,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dashboardState.formattedHijriDate,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary.withOpacity(0.8),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.bell, size: 20),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Motto
                  EntranceFader(
                    delay: const Duration(milliseconds: 100),
                    child: DailyMottoCard(), 
                  ),

                  const SizedBox(height: 16),

                  // Timer
                  const EntranceFader(
                    delay: Duration(milliseconds: 150),
                    child: NextPrayerCard(),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Tasks Header & List
                  EntranceFader(
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Şahsiyet Görevleri',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.cardDark,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$activeTaskCount Aktif',
                                style: const TextStyle(
                                    color: AppColors.primary, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Dynamic Task List
                        ...tasks.map((task) => TaskListItem(
                          task: task,
                          onTap: () {
                            ref.read(taskControllerProvider.notifier).toggleTaskCompletion(task.id);
                          },
                        )),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Daily Wisdom
                  EntranceFader(
                    delay: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Günün Hikmeti',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Tümünü gör'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.accentGold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const DailyWisdomCard(),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Banner
                  EntranceFader(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderGold.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  LucideIcons.barChart2,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Karakter Gelişimi',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'İlerlemeni gör',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(LucideIcons.chevronRight, color: Colors.white30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
