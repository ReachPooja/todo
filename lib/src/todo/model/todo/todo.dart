import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo extends Equatable {
  const Todo({
    required this.name,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.subtasks,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  final String name;
  final String description;
  final String dueDate;
  final String category;
  final List<String> subtasks;

  @override
  List<Object> get props {
    return [
      name,
      description,
      dueDate,
      category,
      subtasks,
    ];
  }
}
