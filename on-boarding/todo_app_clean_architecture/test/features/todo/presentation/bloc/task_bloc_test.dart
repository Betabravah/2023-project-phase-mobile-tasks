import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app_clean_architecture/core/util/input_convertor.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/usecases.dart'
    as usecases;
import 'package:todo_app_clean_architecture/features/todo/presentation/bloc/task_bloc.dart';

import 'task_bloc_test.mocks.dart';

@GenerateMocks([
  InputConverter,
  usecases.ViewAllTasks,
  usecases.GetTask,
  usecases.CreateTask,
  usecases.EditTask,
  usecases.RemoveTask
])
void main() {
  late TaskBloc taskBloc;
  late MockInputConverter mockInputConvertor;
  late MockViewAllTasks mockViewAllTasks;
  late MockGetTask mockGetTask;
  late MockCreateTask mockCreateTask;
  late MockEditTask mockEditTask;
  late MockRemoveTask mockRemoveTask;
  setUp(() {
    mockInputConvertor = MockInputConverter();

    mockViewAllTasks = MockViewAllTasks();
    mockGetTask = MockGetTask();
    mockCreateTask = MockCreateTask();
    mockEditTask = MockEditTask();
    mockRemoveTask = MockRemoveTask();

    taskBloc = TaskBloc(
      createTask: mockCreateTask,
      deleteTask: mockRemoveTask,
      updateTask: mockEditTask,
      getTask: mockGetTask,
      getAllTasks: mockViewAllTasks,
      inputConvertor: mockInputConvertor,
    );
  });

  const tTaskId = 1;

  final tDate = DateTime(2020, 1, 1);

  const tDateString = '2020-01-01';

  final tTask = Task(
    id: 1,
    title: 'Task 1',
    description: 'Task description',
    dueDate: DateTime(2020, 1, 1),
    isCompleted: false,
  );

  void setUpMockInputConvertorSucces() =>
      when(mockInputConvertor.stringToDateTime(any, future: true))
          .thenAnswer((_) => Right(tDate));

  group('task bloc', () {
    test('initial state should be Initialstate', () async {
      expect(taskBloc.state, equals(InitialState()));
    });

    blocTest<TaskBloc, TaskState>(
      'should emit [Loading, LoadedAllTasks] states for GetAllTasks event',
      build: () => taskBloc,
      act: (bloc) async {
        when(mockViewAllTasks(any)).thenAnswer((_) async => const Right([]));

        bloc.add(LoadAllTasksEvent());

        await untilCalled(
            mockViewAllTasks(any)); // Wait until the mock method is called
      },
      expect: () => [LoadingState(), const LoadedAllTasksState([])],
    );
    blocTest<TaskBloc, TaskState>(
      'should emit Loading, LoadedSingleTask states for GetTask event',
      build: () => taskBloc,
      act: (bloc) async {
        when(mockGetTask(any)).thenAnswer((_) async => Right(tTask));

        bloc.add(const GetSingleTaskEvent(id: tTaskId));

        await untilCalled(
            mockGetTask(any)); // Wait until the mock method is called
      },
      expect: () => [LoadingState(), LoadedSingleTaskState(tTask)],
    );
    blocTest<TaskBloc, TaskState>(
      'should emit [Loading, CreatedTask] states for CreateTask event',
      build: () => taskBloc,
      act: (bloc) async {
        when(mockCreateTask(any)).thenAnswer((_) async => Right(tTask));
        setUpMockInputConvertorSucces();

        bloc.add(CreateTaskEvent(
            title: tTask.title,
            description: tTask.description,
            dueDate: tDateString));

        await untilCalled(
            mockCreateTask(any)); // Wait until the mock method is called
      },
      expect: () => [LoadingState(), CreatedTaskState(tTask)],
    );
    blocTest<TaskBloc, TaskState>(
      'should emit [Loading, UpdatedTask] states for UpdateTask event',
      build: () => taskBloc,
      act: (bloc) async {
        when(mockEditTask(any)).thenAnswer((_) async => Right(tTask));
        setUpMockInputConvertorSucces();

        bloc.add(UpdateTaskEvent(
            id: tTaskId,
            title: tTask.title,
            description: tTask.description,
            dueDate: tDateString,
            isCompleted: false));

        await untilCalled(
            mockEditTask(any)); // Wait until the mock method is called
      },
      expect: () => [LoadingState(), UpdatedTaskState(tTask)],
    );
    blocTest<TaskBloc, TaskState>(
      'should emit DeletedTaskState for DeleteTask event',
      build: () => taskBloc,
      act: (bloc) async {
        when(mockRemoveTask(any)).thenAnswer((_) async => Right(tTask));

        bloc.add(const DeleteTaskEvent(id: tTaskId));

        await untilCalled(
            mockRemoveTask(any)); // Wait until the mock method is called
      },
      expect: () => [DeletedTaskState(tTask)],
    );
  });
}
