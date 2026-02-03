import 'package:sahsiyet/src/core/services/local_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahsiyet/src/features/dashboard/domain/task_model.dart';

class TaskController extends StateNotifier<List<TaskModel>> {
  TaskController() : super([]) {
    _loadTasks();
  }

  static const String _storageKey = 'tasks_data';

  static final List<TaskModel> _initialTasks = [
    const TaskModel(
      id: '1',
      title: 'Bugün birine selam ver',
      description: 'Toplumsal bağları güçlendir',
      type: TaskType.sunnet,
      isCompleted: false,
    ),
    const TaskModel(
      id: '2',
      title: 'Bir engeli kaldır',
      description: 'Yoldan veya kalpten',
      type: TaskType.iyilik,
      isCompleted: false,
    ),
    const TaskModel(
      id: '3',
      title: 'Akşam Muhasebesi',
      description: 'Akşam namazından sonra açılır.',
      type: TaskType.ibadet,
      isLocked: true,
      isCompleted: false,
    ),
  ];

  Future<void> _loadTasks() async {
    final savedList = LocalStorageService.getList(_storageKey);
    
    if (savedList != null && savedList.isNotEmpty) {
      final tasks = savedList.map((item) => TaskModel.fromJson(item)).toList();
      state = tasks;
    } else {
      // First run: load initials and save them
      state = _initialTasks;
      _saveTasks();
    }
  }

  Future<void> _saveTasks() async {
    final list = state.map((t) => t.toJson()).toList();
    await LocalStorageService.saveList(_storageKey, list);
  }

  void toggleTaskCompletion(String taskId) {
    state = [
      for (final task in state)
        if (task.id == taskId && !task.isLocked)
          task.copyWith(isCompleted: !task.isCompleted)
        else
          task
    ];
    _saveTasks();
  }
}

final taskControllerProvider = StateNotifierProvider<TaskController, List<TaskModel>>((ref) {
  return TaskController();
});
