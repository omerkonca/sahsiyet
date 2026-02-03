import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sahsiyet/src/common_widgets/animations/entrance_fader.dart';
import 'package:sahsiyet/src/core/theme/app_colors.dart';
import 'package:sahsiyet/src/features/library/presentation/controllers/library_controller.dart';
import 'package:sahsiyet/src/features/library/presentation/library_detail_screen.dart';
import 'package:sahsiyet/src/features/library/presentation/widgets/library_item_card.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryState = ref.watch(libraryControllerProvider);
    final controller = ref.read(libraryControllerProvider.notifier);
    
    final categories = ['Tümü', 'Dualar', 'Hadisler', 'Tesbihat'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Text(
                'Kütüphane',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  onChanged: (value) => controller.updateSearchQuery(value),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    icon: Icon(LucideIcons.search, color: Colors.white54),
                    hintText: 'Kütüphanede ara...',
                    hintStyle: TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: categories.map((category) {
                  final isSelected = libraryState.selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(category),
                      onSelected: (bool selected) {
                        if (selected) {
                          controller.updateCategory(category);
                        }
                      },
                      backgroundColor: AppColors.cardDark,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.backgroundDark : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.primary : Colors.white.withOpacity(0.1),
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Content List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100), // Bottom nav space
                itemCount: libraryState.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = libraryState.filteredItems[index];
                  return EntranceFader(
                    delay: Duration(milliseconds: index * 50),
                    child: LibraryItemCard(
                      id: item.id,
                      title: item.title,
                      subtitle: item.category,
                      icon: _getCategoryIcon(item.category),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => LibraryDetailScreen(item: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Dualar':
        return LucideIcons.bookOpen;
      case 'Hadisler':
        return LucideIcons.scroll;
      case 'Tesbihat':
        return LucideIcons.repeat;
      default:
        return LucideIcons.book;
    }
  }
}
