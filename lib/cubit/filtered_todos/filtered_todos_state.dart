part of 'filtered_todos_cubit.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> todos;
  const FilteredTodosState({
    required this.todos,
  });

  @override
  List<Object> get props => [todos];

  FilteredTodosState copyWith({
    List<Todo>? todos,
  }) {
    return FilteredTodosState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'FilteredTodosState(todos: $todos)';
}
