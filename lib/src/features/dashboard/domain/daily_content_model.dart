class DailyContentModel {
  final DateTime date;
  final String motto;
  final String mottoAuthor;
  final String wisdomText; // Hikmet/Ayet metni
  final String wisdomSource; // Sure/Ayet No

  const DailyContentModel({
    required this.date,
    required this.motto,
    required this.mottoAuthor,
    required this.wisdomText,
    required this.wisdomSource,
  });
}
