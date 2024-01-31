import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:todo_app_patrizia/core/global/theme/color_theme.dart';
import 'package:todo_app_patrizia/core/utils/app_string.dart';
import 'package:todo_app_patrizia/core/utils/geter_and_func.dart';
import 'package:todo_app_patrizia/cubit/todo_search/todo_search_cubit.dart';

class MainAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isMain;
  const MainAppbar({
    Key? key,
    required this.title,
    this.isMain = false,
  }) : super(key: key);

  @override
  State<MainAppbar> createState() => _MainAppbarState();
  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class _MainAppbarState extends State<MainAppbar> {
  late final TextEditingController textEditingController;
  final FocusNode focusTextField = FocusNode();
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white.withOpacity(0.8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 28, right: 35, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.isMain
                          ? const WeekDayText()
                          : IconsAppbar(
                              iconData: Icons.arrow_back_sharp,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                      widget.isMain ? const DateText() : const SizedBox(),
                      const Spacer(),
                      IconsAppbar(
                        iconData: Icons.more_horiz,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, bottom: 20),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: widget.isMain
                                ? Colors.black
                                : ColorTheme.tundora2,
                          ),
                    ),
                    const Spacer(),
                    widget.isMain ? const SizedBox() : const WeekDayText(),
                    widget.isMain ? const SizedBox() : const DateText(),
                  ],
                ),
              )
            ],
          ),
        ),
        if (widget.isMain)
          Positioned(
            left: 0,
            right: 0,
            bottom: -35,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: mediaQ(context).size.width * 0.8,
                height: 50,
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusTextField,
                  decoration: InputDecoration(
                    fillColor: ColorTheme.white,
                    filled: true,
                    hintText: AppString.search,
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ColorTheme.azalea,
                          width: 6,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: ColorTheme.azalea,
                          width: 6,
                        )),
                  ),
                  onChanged: (value) {
                    BlocProvider.of<TodoSearchCubit>(context)
                        .changeSearchText(value);
                  },
                ),
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}

class IconsAppbar extends StatelessWidget {
  final IconData iconData;
  final void Function()? onPressed;
  const IconsAppbar({
    Key? key,
    required this.iconData,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      height: 25,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onPressed,
        icon: Icon(
          iconData,
          size: 25,
        ),
      ),
    );
  }
}

Jalali date = Jalali.now();
List textDate = date.formatFullDate().split(" ");

class DateText extends StatelessWidget {
  const DateText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        textDate.length > 4 ? "${textDate[0]} ${textDate[1]}" : textDate[0],
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class WeekDayText extends StatelessWidget {
  const WeekDayText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textDate.length > 4
          ? "${textDate[2]} ${textDate[3]} ${textDate[4]}"
          : "${textDate[2]} ${textDate[3]}",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorTheme.dustyGray,
            fontWeight: FontWeight.bold,
          ),
      textDirection: TextDirection.rtl,
    );
  }
}
