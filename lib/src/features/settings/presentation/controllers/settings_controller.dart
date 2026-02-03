import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/core/services/local_storage_service.dart';

class SettingsState {
  final bool notificationsEnabled;
  final bool isDarkTheme;

  SettingsState({
    required this.notificationsEnabled,
    required this.isDarkTheme,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? isDarkTheme,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController()
      : super(SettingsState(notificationsEnabled: true, isDarkTheme: true)) {
    _loadSettings();
  }

  static const String _notificationsKey = 'settings_notifications';
  // static const String _themeKey = 'settings_theme'; // Future use

  Future<void> _loadSettings() async {
    final notifications = LocalStorageService.getBool(_notificationsKey) ?? true;
    // Theme is forced dark for now, but logic is ready
    state = SettingsState(
      notificationsEnabled: notifications,
      isDarkTheme: true,
    );
  }

  Future<void> toggleNotifications(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    await LocalStorageService.saveBool(_notificationsKey, value);
  }

  Future<void> clearAllData() async {
    // This requires clearing specific keys we know about
    await LocalStorageService.saveString('tasks_data', '[]'); // Empty list
    await LocalStorageService.saveString('progress_data', '{}'); // Empty object
    // Note implementation: we are overwriting with empty/default JSON 
    // instead of 'clearing' because LocalStorageService wrapper doesn't expose clear() yet.
    // Ideally we would add clear() to the service. For now this works.
  }
}

final settingsControllerProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController();
});
