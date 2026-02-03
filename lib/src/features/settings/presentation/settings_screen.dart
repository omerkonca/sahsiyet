import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/settings/presentation/controllers/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Preferences Section
          const _SectionHeader(title: 'Tercihler'),
          const SizedBox(height: 8),
          
          _SettingsTile(
            icon: LucideIcons.bell,
            title: 'Bildirimler',
            subtitle: 'Günlük hatırlatıcılar al',
            trailing: Switch(
              value: state.notificationsEnabled,
              onChanged: (value) => controller.toggleNotifications(value),
              activeColor: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 16),
          
          _SettingsTile(
            icon: LucideIcons.moon,
            title: 'Karanlık Mod',
            subtitle: 'Şahsiyet özel teması',
            trailing: Switch(
              value: true, // Always true for now
              onChanged: null, // Disabled
              activeColor: AppColors.primary.withOpacity(0.5),
            ),
          ),

          const SizedBox(height: 32),

          // Data Section
          const _SectionHeader(title: 'Veri ve Gizlilik'),
          const SizedBox(height: 8),

          _SettingsTile(
            icon: LucideIcons.trash2,
            title: 'Verileri Sıfırla',
            subtitle: 'Tüm görev ve ilerlemeni siler',
            iconColor: Colors.redAccent,
            onTap: () async {
               final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.cardDark,
                  title: const Text('Emin misin?', style: TextStyle(color: Colors.white)),
                  content: const Text(
                    'Tüm kazanımların ve görev geçmişin silinecek. Bu işlem geri alınamaz.',
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('İptal', style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Sil', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await controller.clearAllData();
                if (context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tüm veriler temizlendi ve sıfırlandı.')),
                  );
                }
              }
            },
          ),

          const SizedBox(height: 32),

          // About Section
          const _SectionHeader(title: 'Hakkında'),
          const SizedBox(height: 8),
          
          const _SettingsTile(
            icon: LucideIcons.info,
            title: 'Versiyon',
            trailing: Text(
              'v1.0.0',
              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold),
            ),
          ),
          
          const SizedBox(height: 48),
          
          Center(
            child: Text(
              'Şahsiyet',
              style: TextStyle(
                color: AppColors.primary.withOpacity(0.3),
                fontSize: 12,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppColors.primary.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: subtitle != null ? Text(
          subtitle!,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ) : null,
        trailing: trailing ?? const Icon(LucideIcons.chevronRight, size: 20, color: Colors.white30),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
