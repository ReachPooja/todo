// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      name: json['name'] as String,
      description: json['description'] as String,
      dueDate: json['dueDate'] as String,
      category: json['category'] as String,
      subtasks:
          (json['subtasks'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'dueDate': instance.dueDate,
      'category': instance.category,
      'subtasks': instance.subtasks,
    };
