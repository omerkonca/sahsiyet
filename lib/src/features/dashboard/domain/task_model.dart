
enum TaskType { sunnet, iyilik, ibadet }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final TaskType type;
  final bool isLocked;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.type,
    this.isLocked = false,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    TaskType? type,
    bool? isLocked,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      type: type ?? this.type,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'type': type.name, // Enum name is reliable
      'isLocked': isLocked,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      type: TaskType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TaskType.sunnet,
      ),
      isLocked: json['isLocked'] as bool,
    );
  }
}
