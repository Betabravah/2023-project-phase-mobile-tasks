import 'package:flutter/material.dart';

import '../../../core/datetime_map.dart';
import '../../../core/constants.dart';

class Task extends StatelessWidget {
  String title;
  DateTime dueDate;
  int priority;

  Task(this.title, this.dueDate, this.priority);

  @override
  Widget build(BuildContext context) {
    int month = int.parse(dueDate.toString().substring(5, 7));
    int day = int.parse(dueDate.toString().substring(8, 10));
    String? monthName = months[month];

    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title[0], style: TextStyle(fontSize: 30)),
        const SizedBox(width: 20),
        Container(width: 100, child: Text(title, style: taskTitleStyle)),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(),
        ),
        Text("$monthName $day, ${dueDate.year}", textAlign: TextAlign.start),
        SizedBox(width: 10),
        SizedBox(
          child: Container(
              color: (priority <= 3) ? colors[priority - 1] : colors[2]),
          width: 5,
          height: 40,
        )
      ]),
    );
  }
}