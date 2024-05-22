part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTask extends TaskEvent {}

class StoreTask extends TaskEvent {
  final Map<String, dynamic> taskData;

  StoreTask({required this.taskData});
}
