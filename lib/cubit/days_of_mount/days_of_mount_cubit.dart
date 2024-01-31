import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_patrizia/model/day_mount.dart';
import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';

part 'days_of_mount_state.dart';

class DaysOfMountCubit extends Cubit<DaysOfMountState> {
  DaysOfMountCubit() : super(DaysOfMountState.initial());
}
