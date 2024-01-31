part of 'todo_filter_cubit.dart';

class TodoFilterState extends Equatable {
  final Filters filter;
  const TodoFilterState({
    required this.filter,
  });
  factory TodoFilterState.initial() =>
      const TodoFilterState(filter: Filters.all);
  @override
  List<Object> get props => [filter];

  TodoFilterState copyWith({
    Filters? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  String toString() => 'TodoFilterState(filter: $filter)';
}
