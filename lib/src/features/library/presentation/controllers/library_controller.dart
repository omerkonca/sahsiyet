import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/features/library/data/library_repository.dart';
import 'package:sahsiyet/src/features/library/domain/library_item_model.dart';

class LibraryState {
  final List<LibraryItemModel> allItems;
  final List<LibraryItemModel> filteredItems;
  final String selectedCategory; // 'Tümü' for all
  final String searchQuery;

  LibraryState({
    required this.allItems,
    required this.filteredItems,
    this.selectedCategory = 'Tümü',
    this.searchQuery = '',
  });

  LibraryState copyWith({
    List<LibraryItemModel>? allItems,
    List<LibraryItemModel>? filteredItems,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return LibraryState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class LibraryController extends StateNotifier<LibraryState> {
  final LibraryRepository _repository;

  LibraryController(this._repository)
      : super(LibraryState(allItems: [], filteredItems: [])) {
    loadItems();
  }

  void loadItems() {
    final items = _repository.getLibraryItems();
    state = LibraryState(allItems: items, filteredItems: items);
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
}

final libraryRepositoryProvider = Provider((ref) => LibraryRepository());

final libraryControllerProvider = StateNotifierProvider<LibraryController, LibraryState>((ref) {
  final repository = ref.watch(libraryRepositoryProvider);
  return LibraryController(repository);
});
