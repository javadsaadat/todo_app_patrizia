import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_patrizia/core/utils/enums.dart';

part 'task_form_btn_state.dart';

class TaskFormBtnCubit extends Cubit<TaskFormBtnState> {
  TaskFormBtnCubit() : super(TaskFormBtnState.initial());

  changeBtn({required TaskFormBtn taskFormBtn}) {
    Map<TaskFormBtn, bool> mapState = Map.of(state.btns);
    mapState[taskFormBtn] = !state.btns[taskFormBtn]!;
    emit(TaskFormBtnState(btns: mapState));
  }
}
