import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Todo {
  final String id;
  final String title;
  final String notes;
  final Jalali? alarm;
  final bool everyDay;
  final bool compelete;
  /* final time timeTodo; */
  Todo({
    String? id,
    required this.title,
    required this.notes,
    required this.alarm,
    required this.everyDay,
    required this.compelete,
  }) : id = id ?? uuid.v4();
}
