import 'package:add_task/feature/presentation/widgets/components.dart';
import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: LightTheme,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: primaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: const [Icon(Icons.more_vert, color: grey300, size: 40)],
            elevation: 0.0,
            backgroundColor: secondaryColor,
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Center(
              child: Text("Create new task",
                  style: titleMedium, textAlign: TextAlign.center),
            ),
            const Divider(
              thickness: 2.0,
            ),
            Container(
                padding: const EdgeInsets.all(40.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: secondaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TaskPropertyName("Main task name"),
                    TaskPropertyValue("UI/UX App Design", false, false),
                    const SizedBox(height: 15.0),
                    TaskPropertyName("Due Date"),
                    TaskPropertyValue("April 29, 2023 12:30 AM", false, true),
                    const SizedBox(height: 15.0),
                    TaskPropertyName("Description"),
                    TaskPropertyValue(
                        "First I have to animate the logo and and later prototyping my design. It's very important",
                        true,
                        false),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: PrimaryButton("Add task"),
                    )
                  ],
                ))
          ]),
        ));
  }
}
