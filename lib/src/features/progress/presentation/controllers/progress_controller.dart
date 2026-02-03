import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/core/services/local_storage_service.dart';
import 'package:sahsiyet/src/features/dashboard/presentation/controllers/task_controller.dart';

class ProgressState {
  final double weeklyStability; // 0.0 to 1.0
  final int currentStreak;
  final int totalPoints;

  ProgressState({
    required this.weeklyStability,
    required this.currentStreak,
    required this.totalPoints,
  });
  Map<String, dynamic> toJson() {
    return {
      'weeklyStability': weeklyStability,
      'currentStreak': currentStreak,
      'totalPoints': totalPoints,
    };
  }

  factory ProgressState.fromJson(Map<String, dynamic> json) {
    return ProgressState(
      weeklyStability: (json['weeklyStability'] as num).toDouble(),
      currentStreak: json['currentStreak'] as int,
      totalPoints: json['totalPoints'] as int,
    );
  }
}

class ProgressController extends StateNotifier<ProgressState> {
  ProgressController(this.ref)
      : super(ProgressState(
          weeklyStability: 0.0,
          currentStreak: 5, 
          totalPoints: 120, 
        )) {
    _loadProgress();
  }

  final Ref ref;
  static const String _storageKey = 'progress_data';

  Future<void> _loadProgress() async {
    final savedData = LocalStorageService.getItem(_storageKey);
    if (savedData != null) {
      state = ProgressState.fromJson(savedData);
    }
    // After loading, we still want to calculate based on tasks, 
    // but we respect the loaded points/streak first.
    _calculateProgress();
  }

  Future<void> _saveProgress() async {
    await LocalStorageService.saveItem(_storageKey, state.toJson());
  }

  void _calculateProgress() {
    // Listen to task changes to update progress live
    ref.listen(taskControllerProvider, (previous, next) {
      if (next.isEmpty) return;
      
      final completed = next.where((t) => t.isCompleted).length;
      final total = next.length;
      final percentage = total > 0 ? completed / total : 0.0;
      
      // Update points based on completion (Simple Logic: 120 base + 10 per task)
      // In a real app, this logic would be more complex (e.g., adding only delta)
      final newPoints = (120 + (completed * 10)).toInt();

      state = ProgressState(
        weeklyStability: percentage,
        currentStreak: state.currentStreak,
        totalPoints: newPoints,
      );
      
      _saveProgress();
    });
    
    // Initial calculation based on current tasks
    final tasks = ref.read(taskControllerProvider);
    if (tasks.isNotEmpty) {
      final completed = tasks.where((t) => t.isCompleted).length;
      final total = tasks.length;
      final percentage = total > 0 ? completed / total : 0.0;
      
       state = ProgressState(
        weeklyStability: percentage,
        currentStreak: state.currentStreak,
        totalPoints: (120 + (completed * 10)).toInt(),
      );
      _saveProgress();
    }
  }
}

final progressControllerProvider = StateNotifierProvider<ProgressController, ProgressState>((ref) {
  return ProgressController(ref);
});
