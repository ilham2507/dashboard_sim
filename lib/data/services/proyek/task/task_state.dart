part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskStoring extends TaskState {}

class TaskStored extends TaskState {}

class TaskError extends TaskState {
  final String error;
  TaskError(this.error);
}
