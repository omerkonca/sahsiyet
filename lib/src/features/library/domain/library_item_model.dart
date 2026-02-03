class LibraryItemModel {
  final String id;
  final String category; // 'Dualar', 'Hadisler' vb.
  final String title;
  final String content; // Detay metni
  final bool isFavorite;

  const LibraryItemModel({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    this.isFavorite = false,
  });
  
  LibraryItemModel copyWith({
    String? id,
    String? category,
    String? title,
    String? content,
    bool? isFavorite,
  }) {
    return LibraryItemModel(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
