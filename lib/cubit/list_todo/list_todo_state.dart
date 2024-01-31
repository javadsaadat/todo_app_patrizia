part of 'list_todo_cubit.dart';

class ListTodoState extends Equatable {
  final List<Todo> todos;
  const ListTodoState({
    required this.todos,
  });
  factory ListTodoState.initial() {
    return ListTodoState(todos: [
      Todo(
          title: "title1",
          notes: "notesnotesno",
          alarm: Jalali.now().withMonth(12),
          everyDay: false,
          compelete: true),
      Todo(
          title: "title1",
          notes: "notesnotesno",
          alarm: Jalali.now().withMonth(12),
          everyDay: false,
          compelete: true),
      Todo(
          title: "title1",
          notes: "notesnotesno",
          alarm: Jalali.now().withMonth(12),
          everyDay: false,
          compelete: true),
    ]);
  }
  @override
  List<Object> get props => [todos];

  ListTodoState copyWith({
    List<Todo>? todos,
  }) {
    return ListTodoState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() => 'ListTodoState(todos: $todos)';
}
