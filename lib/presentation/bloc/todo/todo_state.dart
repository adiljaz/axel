// presentation/cubit/todo/todo_state.dart
import 'package:equatable/equatable.dart';
import '../../../domain/entities/todo.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final bool hasReachedMax;
  final bool isSearching;

  TodoLoaded({
    required this.todos,
    this.hasReachedMax = false,
    this.isSearching = false,
  });

  TodoLoaded copyWith({
    List<Todo>? todos,
    bool? hasReachedMax,
    bool? isSearching,
  }) {
    return TodoLoaded(
      todos: todos ?? this.todos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [todos, hasReachedMax, isSearching];
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  List<Object?> get props => [message];
}

class TodoEmpty extends TodoState {}
