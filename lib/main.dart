import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_patrizia/core/global/theme/theme_data_app.dart';
import 'package:todo_app_patrizia/cubit/days_of_mount/days_of_mount_cubit.dart';
import 'package:todo_app_patrizia/cubit/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_app_patrizia/cubit/list_todo/list_todo_cubit.dart';
import 'package:todo_app_patrizia/cubit/task_form_btn/task_form_btn_cubit.dart';
import 'package:todo_app_patrizia/cubit/todo_filter/todo_filter_cubit.dart';
import 'package:todo_app_patrizia/cubit/todo_search/todo_search_cubit.dart';
import 'package:todo_app_patrizia/screens/main_page/main_page.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DaysOfMountCubit(),
        ),
        BlocProvider(
          create: (context) => ListTodoCubit(),
        ),
        BlocProvider(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider(
          create: (context) => TodoFilterCubit(),
        ),
        BlocProvider(
          create: (context) => FilteredTodosCubit(
            listTodoCubit: BlocProvider.of<ListTodoCubit>(context),
            todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
          ),
        ),
        BlocProvider(
          create: (context) => TaskFormBtnCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo Patrizia',
        debugShowCheckedModeBanner: false,
        theme: ThemeApp.themelight,
        home: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/Fun & Free iPhone Wallpapers - cute Mobile Backgrounds.jpg",
              ),
            ),
          ),
          child: /* const NewTask() */ const MainPage(),
        ),
      ),
    );
  }
}
