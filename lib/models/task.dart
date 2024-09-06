import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  String id;
  String title;
  String description;
  DateTime createdAt;
  DateTime? dueDate;
  DateTime? completedAt;
  bool isCompleted;
  int? rewardInSatoshis;

  Task({
    String? id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.dueDate,
    this.completedAt,
    this.isCompleted = false,
    this.rewardInSatoshis = 0,
  }) : id = id ?? const Uuid().v4();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id']?.toString(), // Convert int to String if necessary
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      dueDate: DateTime.parse(json['due_date'] as String),
      isCompleted: json['is_completed'] as bool,
      rewardInSatoshis: json['reward_in_satoshis'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'due_date': dueDate?.toIso8601String(),
      'is_completed': isCompleted,
      'reward_in_satoshis': rewardInSatoshis,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'isCompleted': isCompleted,
      'rewardInSatoshis': rewardInSatoshis,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      dueDate: DateTime.parse(map['dueDate']),
      completedAt: (map['completedAt'] == null || map['completedAt'] == 'null')
          ? null
          : DateTime.parse(map['completedAt']),
      isCompleted: map['isCompleted'] == 0 ? false : true,
      rewardInSatoshis: map['rewardInSatoshis'],
    );
  }
}
