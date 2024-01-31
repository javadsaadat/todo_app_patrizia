import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_patrizia/model/todo.dart';
import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';
import 'package:todo_app_patrizia/core/utils/app_string.dart';
import 'package:todo_app_patrizia/cubit/filtered_todos/filtered_todos_cubit.dart';
import 'package:todo_app_patrizia/cubit/list_todo/list_todo_cubit.dart';
import 'package:todo_app_patrizia/screens/general_widgets/main_appbar.dart';
import 'package:todo_app_patrizia/screens/main_page/widget/seven_day_today.dart';
import 'package:todo_app_patrizia/screens/main_page/widget/tabbar_main.dart';
import 'package:todo_app_patrizia/screens/main_page/widget/todo_display_main.dart';
import 'package:todo_app_patrizia/screens/new_task/new_task.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const MainAppbar(
            title: "ToDo List",
            isMain: true,
          ),
          const SevenDayToday(),
          const TabbarMain(),
          Expanded(
            child: BlocBuilder<FilteredTodosCubit, FilteredTodosState>(
              builder: (context, state) {
                if (state.todos.isNotEmpty) {
                  return ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 85.0),
                    children: [
                      ...List.generate(
                        state.todos.length,
                        (index) => TodoDisplayMain(todo: state.todos[index]),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: Text(
                        AppString.listEmpty,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NewTask(),
              ),
            );
          },
          shape: const CircleBorder(),
          backgroundColor: ColorTheme.white,
          elevation: 20,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      /* bottomNavigationBar: const BottomNavigationBarMain(), */
    );
  }
}
