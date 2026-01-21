// presentation/bloc/todo/todo_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/todo/get_todos_usecase.dart';
import '../../../domain/usecases/todo/toggle_favorite_usecase.dart';
import '../../../domain/usecases/todo/search_todos_usecase.dart';
import '../../../domain/entities/todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final SearchTodosUseCase searchTodosUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.toggleFavoriteUseCase,
    required this.searchTodosUseCase,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<SearchTodosEvent>(_onSearchTodos);
    on<ClearSearchEvent>(_onClearSearch);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (event.isRefresh) {
      emit(TodoLoading());
    } else if (state is TodoInitial) {
      emit(TodoLoading());
    }

    final result = await getTodosUseCase(page: event.page ?? 1, limit: 20);
    
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) {
        if (todos.isEmpty) {
          emit(TodoEmpty());
        } else {
          final currentState = state;
          if (currentState is TodoLoaded && !event.isRefresh) {
            final updatedTodos = List<Todo>.from(currentState.todos)..addAll(todos);
            emit(TodoLoaded(
              todos: updatedTodos,
              hasReachedMax: todos.length < 20,
            ));
          } else {
            emit(TodoLoaded(
              todos: todos,
              hasReachedMax: todos.length < 20,
            ));
          }
        }
      },
    );
  }

  Future<void> _onSearchTodos(
    SearchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(LoadTodosEvent());
      return;
    }

    final result = await searchTodosUseCase(event.query);
    
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) {
        if (todos.isEmpty) {
          emit(TodoEmpty());
        } else {
          emit(TodoLoaded(todos: todos, isSearching: true));
        }
      },
    );
  }

  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<TodoState> emit,
  ) async {
    add(LoadTodosEvent(isRefresh: true));
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<TodoState> emit,
  ) async {
    final currentState = state;
    if (currentState is TodoLoaded) {
      final result = await toggleFavoriteUseCase(event.todoId);
      
      result.fold(
        (failure) => {}, // Silent fail for favorites
        (updatedTodo) {
          final updatedTodos = currentState.todos.map((todo) {
            return todo.id == updatedTodo.id ? updatedTodo : todo;
          }).toList();
          
          emit(currentState.copyWith(todos: updatedTodos));
        },
      );
    }
  }

  Future<void> loadTodos({int? page, bool isRefresh = false}) async {
    add(LoadTodosEvent(page: page, isRefresh: isRefresh));
  }

  Future<void> searchTodos(String query) async {
    add(SearchTodosEvent(query));
  }

  Future<void> clearSearch() async {
    add(ClearSearchEvent());
  }

  Future<void> toggleFavorite(int todoId) async {
    add(ToggleFavoriteEvent(todoId));
  }
}