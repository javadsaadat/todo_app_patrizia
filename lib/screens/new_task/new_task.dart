import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:todo_app_patrizia/core/utils/app_string.dart';
import 'package:todo_app_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_patrizia/screens/general_widgets/main_appbar.dart';
import 'package:todo_app_patrizia/screens/new_task/widget/display_date.dart';
import 'package:todo_app_patrizia/screens/new_task/widget/form_add_todo.dart';

class NewTask extends StatelessWidget {
  final String? id;
  const NewTask({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Jalali.now().withDay(23).datePickerMediumDate());
    return Scaffold(
      appBar: MainAppbar(
        title: id == null ? AppString.newTask : AppString.edit,
        isMain: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DisplayDate(),
            Padding(
              padding: EdgeInsets.only(
                bottom: mediaQ(context).viewInsets.bottom,
              ),
              child: FormAddTodo(id: id),
            )
          ],
        ),
      ),
    );
  }
}
