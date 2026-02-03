import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/core/database/database_service.dart';
import 'package:sahsiyet/src/features/library/domain/library_item_model.dart';

class LibraryState {
  final List<LibraryItemModel> allItems;
  final List<LibraryItemModel> filteredItems;
  final String selectedCategory;
  final String searchQuery;
  final bool isLoading;

  LibraryState({
    required this.allItems,
    required this.filteredItems,
    this.selectedCategory = 'Tümü',
    this.searchQuery = '',
    this.isLoading = false,
  });

  LibraryState copyWith({
    List<LibraryItemModel>? allItems,
    List<LibraryItemModel>? filteredItems,
    String? selectedCategory,
    String? searchQuery,
    bool? isLoading,
  }) {
    return LibraryState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LibraryController extends StateNotifier<LibraryState> {
  LibraryController()
      : super(LibraryState(allItems: [], filteredItems: [], isLoading: true)) {
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      final data = await DatabaseService.getAllLibraryContent();
      final items = data.map((item) => LibraryItemModel(
        id: item['content_id'],
        title: item['title'],
        content: item['content'],
        category: item['category'],
        reference: item['reference'],
        transliteration: item['transliteration'],
        translation: item['translation'],
        isFavorite: item['is_favorite'] == 1,
      )).toList();
      
      state = LibraryState(allItems: items, filteredItems: items, isLoading: false);
    } catch (e) {
      print('Error loading library items: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void updateCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    var items = state.allItems;

    // Category Filter
    if (state.selectedCategory != 'Tümü') {
      items = items.where((item) => item.category == state.selectedCategory).toList();
    }

    // Search Filter
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      items = items.where((item) =>
          item.title.toLowerCase().contains(query) ||
          item.content.toLowerCase().contains(query)).toList();
    }

    state = state.copyWith(filteredItems: items);
  }

  Future<void> toggleFavorite(String contentId, bool isFavorite) async {
    await DatabaseService.toggleFavorite(contentId, isFavorite);
    await loadItems();
  }
}

final libraryControllerProvider = StateNotifierProvider<LibraryController, LibraryState>((ref) {
  return LibraryController();
});
