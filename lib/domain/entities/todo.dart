// domain/entities/todo.dart
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final int userId;
  final String title;
  final bool completed;
  final bool isFavorite;

  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, userId, title, completed, isFavorite];
}