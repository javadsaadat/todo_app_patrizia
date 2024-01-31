part of 'todo_search_cubit.dart';

class TodoSearchState extends Equatable {
  final String searchText;
  const TodoSearchState(
    this.searchText,
  );
  factory TodoSearchState.initial() => const TodoSearchState("");
  @override
  List<Object> get props => [searchText];

  TodoSearchState copyWith({
    String? searchText,
  }) {
    return TodoSearchState(
      searchText ?? this.searchText,
    );
  }

  @override
  String toString() => 'TodoSearchState(searchText: $searchText)';
}
