part of 'days_of_mount_cubit.dart';

class DaysOfMountState extends Equatable {
  final List<DayMount> days;
  const DaysOfMountState({
    required this.days,
  });
  factory DaysOfMountState.initial() {
    Jalali dateNow = Jalali.now();

    List<DayMount> dates = List.generate(29, (index) {
      ++index;
      return DayMount(
        date: dateNow.withDay(index),
        bgColor: colorDay(
          dateNow.withDay(index),
        )[0],
        fgColor: colorDay(
          dateNow.withDay(index),
        )[1],
      );
    });
    return DaysOfMountState(days: dates);
  }

  @override
  List<Object> get props => [days];

  DaysOfMountState copyWith({
    List<DayMount>? days,
  }) {
    return DaysOfMountState(
      days: days ?? this.days,
    );
  }

  @override
  String toString() => 'DaysOfMountState(days: $days)';
}

List<Color> colorDay(Jalali dateParam) {
  switch (dateParam.compareTo(Jalali.now())) {
    case 0:
      return [ColorTheme.azalea, ColorTheme.black];

    case 1:
      if (dateParam.formatFullDate().split(" ")[0] == "پنج") {
        return [ColorTheme.silverChalice2.withOpacity(0.2), ColorTheme.black];
      }
      if (dateParam.formatFullDate().split(" ")[0] == "جمعه") {
        return [ColorTheme.linkBlue.withOpacity(0.4), ColorTheme.black];
      }
      return [ColorTheme.white, ColorTheme.black];
    case -1:
      return [
        ColorTheme.silverChalice1_1.withOpacity(0.2),
        ColorTheme.silverChalice2.withOpacity(0.7),
      ];
  }
  return [];
}
