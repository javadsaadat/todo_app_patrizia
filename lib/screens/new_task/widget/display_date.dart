import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:todo_app_patrizia/model/day_mount.dart';
import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';
import 'package:todo_app_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_patrizia/cubit/days_of_mount/days_of_mount_cubit.dart';
import 'package:todo_app_patrizia/screens/general_widgets/day_of_mount.dart';

class DisplayDate extends StatelessWidget {
  const DisplayDate({super.key});

  @override
  Widget build(BuildContext context) {
    Jalali dateNow = Jalali.now();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        /*  padding: const EdgeInsets.all(20), */
        width: mediaQ(context).size.width,
        height: mediaQ(context).size.width * 0.79,
        decoration: BoxDecoration(
            color: ColorTheme.silverChalice1,
            borderRadius:
                BorderRadius.circular(mediaQ(context).size.width * 0.09)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          JalaliDate.months[(dateNow.month) == 0
                              ? 12
                              : (dateNow.month) -
                                  2], //for list start 0 and for next mount
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorTheme.linkBlue,
                                  ),
                        ),
                      ),
                    ),
                    Text(
                      JalaliDate.months[dateNow.month - 1],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorTheme.azalea,
                          ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 15,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          JalaliDate.months[(dateNow.month - 1) == 11
                              ? 0
                              : (dateNow
                                  .month)], //for list start 0 and for next mount
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorTheme.linkBlue,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<DaysOfMountCubit, DaysOfMountState>(
                  builder: (context, state) {
                    print(state.days.length);
                    return GridView.builder(
                      itemCount: state.days.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 70 / 70,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 3,
                      ),
                      itemBuilder: (context, index) {
                        DayMount dayMount = state.days[index];
                        List<String> textDate =
                            dayMount.date.formatFullDate().split(" ");
                        return DayOfMount(
                          numDay: dayMount.date.day.toString(),
                          weekday: textDate.length > 4
                              ? "${textDate[0]} ${textDate[1]}"
                              : textDate[0],
                          bgColor: dayMount.bgColor,
                          fgColor: dayMount.fgColor,
                          width: 70,
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
