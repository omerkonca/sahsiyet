import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/library/domain/library_item_model.dart';

class LibraryDetailScreen extends StatelessWidget {
  final LibraryItemModel item;

  const LibraryDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
              color: item.isFavorite ? AppColors.primary : Colors.white,
            ),
            onPressed: () {
              // Favori işlemleri buraya (İleride)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'library_icon_${item.id}',
                child: Icon(
                  _getIconForCategory(item.category),
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.category,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Text(
                item.content,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Paylaş butonu vs. eklenebilir
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(LucideIcons.share2, size: 18),
                label: const Text('Paylaş'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.backgroundDark,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  IconData _getIconForCategory(String category) {
    if (category == 'Dualar') return LucideIcons.bookOpen;
    if (category == 'Hadisler') return LucideIcons.scroll;
    if (category == 'Tesbihat') return LucideIcons.repeat;
    return LucideIcons.book;
  }
}
