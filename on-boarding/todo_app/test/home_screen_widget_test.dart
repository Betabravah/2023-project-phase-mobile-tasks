import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app/feature/presentation/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays the expected widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Your tasks'), findsOneWidget);
    expect(
        find.image(const AssetImage('assets/images/todo.png')), findsOneWidget);
  });
}
