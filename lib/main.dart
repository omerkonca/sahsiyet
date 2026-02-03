import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sahsiyet/src/core/services/local_storage_service.dart';
import 'src/core/theme/app_theme.dart';
import 'src/main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
  await LocalStorageService.init(); // Initialize Storage
  runApp(const ProviderScope(child: SahsiyetApp()));
}

class SahsiyetApp extends StatelessWidget {
  const SahsiyetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Şahsiyet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme, // Sadece Dark Mode kullanıyoruz şimdilik
      themeMode: ThemeMode.dark,
      home: const MainLayout(),
    );
  }
}
