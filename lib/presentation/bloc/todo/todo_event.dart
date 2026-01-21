import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends TodoEvent {
  final int? page;
  final bool isRefresh;

  const LoadTodosEvent({this.page, this.isRefresh = false});

  @override
  List<Object?> get props => [page, isRefresh];
}

class SearchTodosEvent extends TodoEvent {
  final String query;

  const SearchTodosEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends TodoEvent {}

class ToggleFavoriteEvent extends TodoEvent {
  final int todoId;

  const ToggleFavoriteEvent(this.todoId);

  @override
  List<Object> get props => [todoId];
}
