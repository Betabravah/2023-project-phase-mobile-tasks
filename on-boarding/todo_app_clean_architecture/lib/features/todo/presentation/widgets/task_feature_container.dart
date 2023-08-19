import 'package:flutter/material.dart';

class TaskFeatureContainer extends StatelessWidget {
  final String title;
  final String feature;
  const TaskFeatureContainer(
      {super.key, required this.title, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 235, 234, 234),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(child: Text(feature)),
        )
      ],
    );
  }
}
