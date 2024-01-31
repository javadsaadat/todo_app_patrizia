import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_patrizia/core/utils/app_string.dart';
import 'package:todo_app_patrizia/core/utils/enums.dart';
import 'package:todo_app_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_patrizia/cubit/todo_filter/todo_filter_cubit.dart';

class TabbarMain extends StatelessWidget {
  const TabbarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQ(context).size.width,
      height: 55,
      child: DefaultTabController(
        length: 3,
        child: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 280,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TabBar(
                onTap: (value) {
                  switch (value) {
                    case 0:
                      BlocProvider.of<TodoFilterCubit>(context)
                          .changeFilter(Filters.values[0]);
                      break;
                    case 1:
                      BlocProvider.of<TodoFilterCubit>(context)
                          .changeFilter(Filters.values[1]);
                      break;
                    case 2:
                      BlocProvider.of<TodoFilterCubit>(context)
                          .changeFilter(Filters.values[2]);
                      break;
                    default:
                  }
                },
                padding: EdgeInsets.zero,
                isScrollable: true,
                /*  indicatorSize: TabBarIndicatorSize.label, */ dividerHeight:
                    0,
                indicatorWeight: 0.2,
                labelStyle: Theme.of(context).textTheme.bodySmall,
                tabs: List.generate(Filters.values.length, (index) {
                  late String lableTab;
                  switch (Filters.values[index]) {
                    case Filters.all:
                      lableTab = AppString.all;
                      break;
                    case Filters.active:
                      lableTab = AppString.active;
                      break;
                    case Filters.complete:
                      lableTab = AppString.compelete;
                      break;
                    default:
                      lableTab = AppString.none;
                  }
                  return Tab(
                    height: 20,
                    text: lableTab,
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
