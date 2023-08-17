import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

// General Failures
class CacheFailure extends Failure {
  final String message;

  const CacheFailure({required this.message}) : super(message: message);
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final String message;

  const ServerFailure({required this.message}) : super(message: message);
  @override
  List<Object> get props => [];
}

class InputValidationFailure extends Failure {
final String message;

const InputValidationFailure({required this.message}) : super(message: message);

  @override
  List<Object?> get props => throw UnimplementedError();
  
}
