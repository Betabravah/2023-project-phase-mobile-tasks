import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/onboarding_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/task_detail_screen.dart';

import 'bloc_observer.dart';
import 'features/todo/domain/entities/task.dart';
import 'features/todo/presentation/screens/add_task_screen.dart';
import 'features/todo/presentation/screens/task_list_screen.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(148, 153, 0, 255),
          secondary: Color(0xFF0C8CE9),
          surface: Color(0xFFF1EEEE),
          background: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          onSurface: Color(0xFF000000),
          onBackground: Color(0xFF000000),
          onError: Color(0xFFFFFFFF),
        ),
        fontFamily: 'Poppins',
      ),
      title: 'Todo App',
      home: const OnboardingScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/add') {
          if (settings.arguments != null) {
            final Task task = settings.arguments as Task;
            return MaterialPageRoute(
              builder: (context) => AddTaskScreen(task),
            );
          }
          return MaterialPageRoute(
            builder: (context) => AddTaskScreen(null),
          );
        }
        //
        else if (settings.name == '/tasks') {
          return MaterialPageRoute(
            builder: (context) => const TaskListScreen(),
          );
        }
        //
        else if (settings.name == '/task-detail') {
          return MaterialPageRoute(
            builder: (context) => TaskDetailScreen(settings.arguments as int),
          );
        }
        //
        else {
          return MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          );
        }
      },
    );
  }
}
