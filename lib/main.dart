import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sahsiyet/src/core/database/database_service.dart';
import 'package:sahsiyet/src/core/database/seed_data.dart';
import 'package:sahsiyet/src/core/services/gemini_service.dart';
import 'package:sahsiyet/src/core/services/local_storage_service.dart';
import 'package:sahsiyet/src/features/onboarding/onboarding_screen.dart';
import 'src/core/theme/app_theme.dart';
import 'src/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await initializeDateFormatting('tr_TR', null);
  await LocalStorageService.init();
  await DatabaseService.database; // Initialize database
  
  // Seed data if needed
  await SeedData.seedAll();
  
  // Initialize Gemini AI
  await GeminiService.init();
  
  runApp(const ProviderScope(child: SahsiyetApp()));
}

class SahsiyetApp extends StatelessWidget {
  const SahsiyetApp({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCompleted = LocalStorageService.getBool('onboarding_completed') ?? false;

    return MaterialApp(
      title: 'Şahsiyet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: onboardingCompleted ? const MainLayout() : const OnboardingScreen(),
    );
  }
}
