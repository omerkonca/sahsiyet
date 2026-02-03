import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/common_widgets/custom_bottom_nav.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:sahsiyet/src/features/library/presentation/library_screen.dart';

import 'package:sahsiyet/src/features/chat/presentation/chat_screen.dart';
import 'package:sahsiyet/src/features/profile/presentation/profile_screen.dart';
import 'package:sahsiyet/src/features/progress/presentation/progress_screen.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    final screens = [
      const DashboardScreen(),
      const LibraryScreen(), // Index 1
      const ChatScreen(), // Index 2 - AI Rehber
      const ProgressScreen(), // Index 3
      const ProfileScreen(), // Index 4
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
