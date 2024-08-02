import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime createdAt;
  DateTime? completedAt;
  bool isCompleted;
  int? rewardInSatoshis;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.completedAt,
    this.isCompleted = false,
    this.rewardInSatoshis = 0,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isCompleted': isCompleted,
      'rewardInSatoshis': rewardInSatoshis,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      completedAt: (map['completedAt'] == null || map['completedAt'] == 'null')
          ? null
          : DateTime.parse(map['completedAt']),
      isCompleted: map['isCompleted'] == 0 ? false : true,
      rewardInSatoshis: map['rewardInSatoshis'],
    );
  }
}
