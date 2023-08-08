import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final DateTime date;
  final int priority;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });
}
