import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_patrizia/model/todo.dart';

part 'list_todo_state.dart';

class ListTodoCubit extends Cubit<ListTodoState> {
  ListTodoCubit() : super(ListTodoState.initial());

  addTodo(Todo todo) {
    final List<Todo> newList = [
      todo,
      ...state.todos,
    ];
    emit(
      state.copyWith(
        todos: newList,
      ),
    );
  }

  rempveTodo(Todo todo) {
    final List<Todo> newList =
        state.todos.where((T) => T.id != todo.id).toList();
    emit(
      state.copyWith(
        todos: newList,
      ),
    );
  }

  edotTodo(Todo todo) {
    final List<Todo> newList =
        state.todos.map((T) => T.id == todo.id ? todo : T).toList();
    emit(
      state.copyWith(
        todos: newList,
      ),
    );
  }

  changeCompleteTodo(Todo todo) {
    final List<Todo> newList = state.todos
        .map<Todo>((T) => T.id == todo.id
            ? Todo(
                title: T.title,
                notes: T.notes,
                alarm: T.alarm,
                everyDay: T.everyDay,
                compelete: !T.compelete,
              )
            : T)
        .toList();
    emit(
      state.copyWith(
        todos: newList,
      ),
    );
  }
}
