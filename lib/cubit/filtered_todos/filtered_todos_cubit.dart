import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app_patrizia/model/todo.dart';
import 'package:todo_app_patrizia/core/utils/enums.dart';
import 'package:todo_app_patrizia/cubit/list_todo/list_todo_cubit.dart';
import 'package:todo_app_patrizia/cubit/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app_patrizia/cubit/todo_search/todo_search_cubit.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final ListTodoCubit listTodoCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  late final StreamSubscription streamSubscriptionListTodo;
  late final StreamSubscription streamSubscriptionTodoFilter;
  late final StreamSubscription streamSubscriptionTodoSearch;
  FilteredTodosCubit({
    required this.listTodoCubit,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
  }) : super(FilteredTodosState(todos: listTodoCubit.state.todos)) {
    streamSubscriptionListTodo = listTodoCubit.stream.listen((event) {
      changeTodoFiltered();
    });
    streamSubscriptionTodoSearch = todoSearchCubit.stream.listen((event) {
      changeTodoFiltered();
    });
    streamSubscriptionTodoFilter = todoFilterCubit.stream.listen((event) {
      changeTodoFiltered();
    });
  }

  changeTodoFiltered() {
    List<Todo> filteredTodoVar = [];

    switch (todoFilterCubit.state.filter) {
      case Filters.all:
        filteredTodoVar = listTodoCubit.state.todos;
        break;
      case Filters.active:
        filteredTodoVar =
            listTodoCubit.state.todos.where((T) => !T.compelete).toList();
        break;
      case Filters.complete:
        filteredTodoVar =
            listTodoCubit.state.todos.where((T) => T.compelete).toList();
        break;
    }
    if (todoSearchCubit.state.searchText.isNotEmpty) {
      filteredTodoVar = filteredTodoVar
          .where((T) => T.title.contains(todoSearchCubit.state.searchText))
          .toList();
    }
    emit(state.copyWith(todos: filteredTodoVar));
  }

  @override
  Future<void> close() {
    streamSubscriptionListTodo.cancel();
    streamSubscriptionTodoFilter.cancel();
    streamSubscriptionTodoSearch.cancel();
    return super.close();
  }
}
