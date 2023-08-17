// Mocks generated by Mockito 5.4.2 from annotations
// in todo_app_clean_architecture/test/features/todo/presentation/bloc/task_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app_clean_architecture/core/error/failures.dart' as _i5;
import 'package:todo_app_clean_architecture/core/usecases/usecase.dart' as _i9;
import 'package:todo_app_clean_architecture/core/util/input_convertor.dart'
    as _i4;
import 'package:todo_app_clean_architecture/features/todo/domain/entities/task.dart'
    as _i8;
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart'
    as _i3;
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/create_task.dart'
    as _i11;
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/edit_task.dart'
    as _i12;
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/get_task.dart'
    as _i10;
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/remove_task.dart'
    as _i13;
import 'package:todo_app_clean_architecture/features/todo/domain/usecases/view_all_tasks.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTaskRepository_1 extends _i1.SmartFake
    implements _i3.TaskRepository {
  _FakeTaskRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockInputConverter extends _i1.Mock implements _i4.InputConverter {
  MockInputConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String dateTimeToString(DateTime? datetime) => (super.noSuchMethod(
        Invocation.method(
          #dateTimeToString,
          [datetime],
        ),
        returnValue: '',
      ) as String);
  @override
  _i2.Either<_i5.InputValidationFailure, DateTime> stringToDateTime(
    String? str, {
    bool? future = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #stringToDateTime,
          [str],
          {#future: future},
        ),
        returnValue: _FakeEither_0<_i5.InputValidationFailure, DateTime>(
          this,
          Invocation.method(
            #stringToDateTime,
            [str],
            {#future: future},
          ),
        ),
      ) as _i2.Either<_i5.InputValidationFailure, DateTime>);
}

/// A class which mocks [ViewAllTasks].
///
/// See the documentation for Mockito's code generation for more information.
class MockViewAllTasks extends _i1.Mock implements _i6.ViewAllTasks {
  MockViewAllTasks() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TaskRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, List<_i8.Task>>> call(
          _i9.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i5.Failure, List<_i8.Task>>>.value(
            _FakeEither_0<_i5.Failure, List<_i8.Task>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i5.Failure, List<_i8.Task>>>);
}

/// A class which mocks [GetTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTask extends _i1.Mock implements _i10.GetTask {
  MockGetTask() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TaskRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.Task>> call(_i10.GetParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>.value(
            _FakeEither_0<_i5.Failure, _i8.Task>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>);
}

/// A class which mocks [CreateTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateTask extends _i1.Mock implements _i11.CreateTask {
  MockCreateTask() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TaskRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.Task>> call(
          _i11.CreateParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>.value(
            _FakeEither_0<_i5.Failure, _i8.Task>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>);
}

/// A class which mocks [EditTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockEditTask extends _i1.Mock implements _i12.EditTask {
  MockEditTask() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TaskRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.Task>> call(_i12.EditParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>.value(
            _FakeEither_0<_i5.Failure, _i8.Task>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>);
}

/// A class which mocks [RemoveTask].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTask extends _i1.Mock implements _i13.RemoveTask {
  MockRemoveTask() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TaskRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TaskRepository);
  @override
  _i7.Future<_i2.Either<_i5.Failure, _i8.Task>> call(
          _i13.DeleteParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>.value(
            _FakeEither_0<_i5.Failure, _i8.Task>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i5.Failure, _i8.Task>>);
}