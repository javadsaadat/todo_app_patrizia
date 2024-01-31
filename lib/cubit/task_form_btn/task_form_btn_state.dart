part of 'task_form_btn_cubit.dart';

class TaskFormBtnState extends Equatable {
  final Map<TaskFormBtn, bool> btns;
  const TaskFormBtnState({
    required this.btns,
  });
  factory TaskFormBtnState.initial() {
    return TaskFormBtnState(btns: {for (var v in TaskFormBtn.values) v: false});
  }
  @override
  List<Object> get props => [btns];

  @override
  String toString() => 'TaskFormBtnState(btns: $btns)';

  TaskFormBtnState copyWith({
    required Map<TaskFormBtn, bool> btns,
  }) {
    return TaskFormBtnState(
      btns: btns,
    );
  }
}
