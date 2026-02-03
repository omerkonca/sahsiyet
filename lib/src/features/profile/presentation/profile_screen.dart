import 'package:flutter/material.dart';
import 'package:sahsiyet/src/common_widgets/animations/entrance_fader.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/profile/presentation/widgets/badge_card.dart';
import 'package:sahsiyet/src/features/profile/presentation/widgets/profile_header.dart';
import 'package:sahsiyet/src/features/profile/presentation/widgets/profile_stats_card.dart';
import 'package:sahsiyet/src/features/settings/presentation/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Background will be handled by scaffold color
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {}, 
          icon: Container(
             padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.05),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          ),
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
              icon: Container(
                 padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
                child: const Icon(Icons.settings, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100), // Bottom nav space
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EntranceFader(
                  delay: Duration(milliseconds: 0),
                  child: ProfileHeader(),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Stats
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: EntranceFader(
                  delay: Duration(milliseconds: 100),
                  child: ProfileStatsCard(),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Badges Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: EntranceFader(
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Manevi Rozetler',
                        style: TextStyle(
                          fontSize: 18,
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
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Badges Grid
              EntranceFader(
                delay: const Duration(milliseconds: 300),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.65, // Adjusted to prevent overflow
                  children: const [
                    BadgeCard(
                      title: 'Seher Ehli',
                      description: '7 Sabah Namazı',
                      icon: Icons.wb_twilight,
                    ),
                    BadgeCard(
                      title: 'Kuran Dostu',
                      description: '30. Cüz Tamamlandı',
                      icon: Icons.menu_book,
                    ),
                    BadgeCard(
                      title: 'Cömertlik',
                      description: '5 Bağış Yapıldı',
                      icon: Icons.volunteer_activism,
                    ),
                    BadgeCard(
                      title: 'Zikir Ehli',
                      description: '1000 Zikir Çekildi',
                      icon: Icons.category, // using category or grid_view as styling
                      isLocked: true,
                    ),
                    BadgeCard(
                      title: 'Ramazan',
                      description: '30 Gün Oruç',
                      icon: Icons.no_meals,
                      isLocked: true,
                    ),
                    BadgeCard(
                      title: 'Cemaat Ehli',
                      description: '3 Etkinlik',
                      icon: Icons.diversity_3,
                      isLocked: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
