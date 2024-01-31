import 'package:flutter/material.dart';

class DayOfMount extends StatelessWidget {
  final String numDay;
  final String weekday;
  final Color bgColor;
  final Color fgColor;
  final double width;

  const DayOfMount({
    Key? key,
    required this.numDay,
    required this.weekday,
    required this.bgColor,
    required this.fgColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: const [
              /*  BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 0),
                spreadRadius: 0,
                blurRadius: 10,
              ), */
            ]),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: width * 0.65,
            height: width * 0.40,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  numDay,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: width * 0.20,
                        height: 0.77,
                        color: fgColor,
                      ),
                ),
                Text(
                  weekday,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: width * 0.15,
                        color: fgColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
