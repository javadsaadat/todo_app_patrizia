import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_patrizia/cubit/filtered_todos/filtered_todos_cubit.dart';

import 'package:todo_app_patrizia/model/todo.dart';
import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';
import 'package:todo_app_patrizia/core/utils/app_string.dart';
import 'package:todo_app_patrizia/core/utils/enums.dart';
import 'package:todo_app_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_patrizia/cubit/list_todo/list_todo_cubit.dart';
import 'package:todo_app_patrizia/cubit/task_form_btn/task_form_btn_cubit.dart';

class FormAddTodo extends StatefulWidget {
  final String? id;
  const FormAddTodo({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<FormAddTodo> createState() => _FormAddTodoState();
}

class _FormAddTodoState extends State<FormAddTodo> {
  final TextEditingController textEditingControllerTitle =
      TextEditingController();

  final TextEditingController textEditingControllerSubtitle =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late bool checkboxForm;
  Jalali? dataAndTimeForm;
  onTapTaskFormBtn(TaskFormBtn T) {
    BlocProvider.of<TaskFormBtnCubit>(context).changeBtn(taskFormBtn: T);
  }

  @override
  void initState() {
    if (widget.id == null) {
      checkboxForm = false;
    } else {
      Todo todo = BlocProvider.of<FilteredTodosCubit>(context)
          .state
          .todos
          .firstWhere((T) => T.id == widget.id);
      checkboxForm = todo.compelete;
      dataAndTimeForm = todo.alarm;
      textEditingControllerTitle.text = todo.title;
      textEditingControllerSubtitle.text = todo.notes;
    }

    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerTitle.clear();
    textEditingControllerSubtitle.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mQ = mediaQ(context);
    final double borderRadius = mQ.size.width * 0.1;
    saveTodo() {
      BlocProvider.of<ListTodoCubit>(context).addTodo(
        Todo(
          title: textEditingControllerTitle.text,
          notes: textEditingControllerSubtitle.text,
          alarm: dataAndTimeForm,
          everyDay: true,
          compelete: checkboxForm,
        ),
      );

      Navigator.of(context).pop();
    }

    editTodo() {
      BlocProvider.of<ListTodoCubit>(context).edotTodo(
        Todo(
          id: widget.id,
          title: textEditingControllerTitle.text,
          notes: textEditingControllerSubtitle.text,
          alarm: dataAndTimeForm,
          everyDay: true,
          compelete: checkboxForm,
        ),
      );

      Navigator.of(context).pop();
    }

    dateTimePicker() async {
      Jalali? pickedDate = await showModalBottomSheet<Jalali>(
        context: context,
        builder: (context) {
          Jalali? tempPickedDate;
          return SizedBox(
            height: 250,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: const Text(
                        'لغو',
                        style: TextStyle(
                          fontFamily: 'Dana',
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: const Text(
                        'تایید',
                        style: TextStyle(
                          fontFamily: 'Dana',
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(tempPickedDate ?? Jalali.now());
                      },
                    ),
                  ],
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(fontFamily: "Dana"),
                      ),
                    ),
                    child: PCupertinoDatePicker(
                      mode: PCupertinoDatePickerMode.dateAndTime,
                      onDateTimeChanged: (Jalali dateTime) {
                        tempPickedDate = dateTime;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        dataAndTimeForm = pickedDate;
      });
    }

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 350,
        height: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          color: ColorTheme.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: 70,
                      child: Checkbox(
                        value: checkboxForm,
                        onChanged: (value) {
                          setState(() {
                            checkboxForm = !checkboxForm;
                          });
                        },
                        splashRadius: 50,
                        activeColor: ColorTheme.azalea,
                        shape: const CircleBorder(),
                        side: BorderSide(color: ColorTheme.azalea, width: 4),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppString.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    height: 0.77,
                                  ),
                            ),
                            TextFieldNewTask(
                              hintText: AppString.titleTaskHInt,
                              controller: textEditingControllerTitle,
                              reuired: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppString.notes,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    height: 0.77,
                                  ),
                            ),
                            TextFieldNewTask(
                              hintText: AppString.subTitleTaskHInt,
                              controller: textEditingControllerSubtitle,
                              reuired: false,
                            ),
                            /*  Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: BlocBuilder<TaskFormBtnCubit,
                                  TaskFormBtnState>(
                                builder: (context, state) {
                                  return Wrap(
                                    children: TaskFormBtn.values
                                        .map(
                                          (T) => InkWell(
                                            onTap: state.btns[T]!
                                                ? null
                                                : () {
                                                    onTapTaskFormBtn(T);
                                                  },
                                            child: ButtonWrapForm(
                                              taskFormBtn: T,
                                              onPressed: state.btns[T]!
                                                  ? () {
                                                      onTapTaskFormBtn(T);
                                                    }
                                                  : null,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  );
                                },
                              ),
                            ), */
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: InkWell(
                                onTap: () {
                                  dateTimePicker();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LableButton(
                                      text: AppString.time,
                                      subText: dataAndTimeForm == null
                                          ? ""
                                          : "${dataAndTimeForm?.hour.toString().length == 2 ? dataAndTimeForm?.hour.toString() : "0${dataAndTimeForm!.hour}"} : ${dataAndTimeForm?.minute.toString().length == 2 ? dataAndTimeForm?.hour.toString() : "0${dataAndTimeForm!.minute}"}",
                                      icon: Icons.timer,
                                    ),
                                    LableButton(
                                      text: AppString.alarm,
                                      subText: dataAndTimeForm == null
                                          ? ""
                                          : "${dataAndTimeForm?.year.toString()}/${dataAndTimeForm?.month.toString()}/${dataAndTimeForm?.day.toString()}",
                                      icon: Icons.notifications,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/Fun & Free iPhone Wallpapers - cute Mobile Backgrounds.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    widget.id == null ? saveTodo() : editTodo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: ColorTheme.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                ),
                child: Text(
                    widget.id == null ? AppString.addTask : AppString.edit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LableButton extends StatelessWidget {
  final String text;
  final String subText;
  final IconData icon;
  const LableButton({
    Key? key,
    required this.text,
    required this.subText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mediaQ(context).size.width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              Icon(
                icon,
                size: 18,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subText,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorTheme.silverChalice2,
                ),
          ),
        ],
      ),
    );
  }
}

class ButtonWrapForm extends StatelessWidget {
  final TaskFormBtn taskFormBtn;

  final void Function()? onPressed;
  const ButtonWrapForm({
    Key? key,
    required this.onPressed,
    required this.taskFormBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String lable;
    IconData iconData = Icons.event_available;
    late Color color;
    switch (taskFormBtn) {
      case TaskFormBtn.today:
        color = ColorTheme.azaleaBlue;
        lable = AppString.today;
        break;
      case TaskFormBtn.tomorrow:
        color = ColorTheme.azalea;
        lable = AppString.tomorrow;
        break;
      case TaskFormBtn.anotherDay:
        color = ColorTheme.azaleaYellow;
        lable = AppString.anotherDay;
        break;
      default:
        color = ColorTheme.azalea;
        lable = AppString.title;
    }
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(
            iconData,
            size: 15,
          ),
          label: Text(
            lable,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: mediaQ(context).size.width * 0.020,
            ),
            textStyle: const TextStyle(fontSize: 12),
            foregroundColor: color,
            backgroundColor: color.withOpacity(0.3),
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  mediaQ(context).size.width * 0.040,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldNewTask extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool reuired;
  const TextFieldNewTask({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.reuired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (reuired) {
            if (value == null || value.isEmpty) {
              return AppString.emptyField;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: const TextStyle(
            fontSize: 5,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorTheme.azalea,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorTheme.azalea,
            ),
          ),
        ),
      ),
    );
  }
}
