import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/feature/presentation/screens/home_screen.dart';
import 'package:todo_app/feature/presentation/screens/add_task_screen.dart';

void main() {
  testWidgets('Can add a task from HomeScreen', (WidgetTester tester) async {
    // Pump the HomeScreen
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    expect(find.text('Your tasks'), findsOneWidget);

    // Tap the Add Task button
    final addTaskButton = find.widgetWithText(ElevatedButton, 'Add Task');
    expect(addTaskButton, findsOneWidget);

    // Scroll to the button if it's off-screen
    await tester.ensureVisible(addTaskButton);
    expect(addTaskButton, findsOneWidget);

    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    // Verify that the AddTaskScreen is displayed
    expect(find.text('New Task'), findsOneWidget);
    expect(find.byType(AddTaskScreen), findsOneWidget);

    // Enter task details in AddTaskScreen
    await tester.enterText(
        find.byKey(const Key('title_text_field')), 'New Task');
    await tester.enterText(
        find.byKey(const Key('description_text_field')), 'Task Description');
    await tester.tap(find.byKey(const Key('date_picker_icon')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK')); // Select a date
    await tester.enterText(find.byKey(const Key('priority_text_field')), '1');

    // Tap the Add Task button
    final addTaskButton2 = find.widgetWithText(ElevatedButton, 'Add Task');
    expect(addTaskButton2, findsOneWidget);

    // Scroll to the button if it's off-screen
    await tester.ensureVisible(addTaskButton2);
    expect(addTaskButton2, findsOneWidget);

    await tester.tap(addTaskButton2);
    await tester.pumpAndSettle();

    // Verify that the task is added to the HomeScreen
    expect(find.text('New Task'), findsOneWidget);
    expect(find.text('Task Description'), findsOneWidget);
  });
}
