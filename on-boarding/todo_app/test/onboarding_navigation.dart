import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/feature/presentation/screens/home_screen.dart';
import 'package:todo_app/feature/presentation/screens/add_task_screen.dart';

void main() {
  testWidgets('Can navigate from HomeScreen to AddTaskScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    final addTaskButton = find.widgetWithText(ElevatedButton, 'Add Task');
    expect(addTaskButton, findsOneWidget);

    // Scroll to the button if it's off-screen
    await tester.ensureVisible(addTaskButton);
    expect(addTaskButton, findsOneWidget);

    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    expect(find.text('New Task'), findsOneWidget);
    expect(find.byType(AddTaskScreen), findsOneWidget);
  });
}
