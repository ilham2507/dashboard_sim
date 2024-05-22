part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class LoadTask extends TaskEvent {}

class GetTaskById extends TaskEvent {
  final String taskId;

  GetTaskById({required this.taskId});
}

class StoreTask extends TaskEvent {
  final Map<String, dynamic> taskData;

  StoreTask({required this.taskData});
}

class UpdateTaskById extends TaskEvent {
  final Map<String, dynamic> proyekData;
  final String proyekId;

  UpdateTaskById({
    required this.proyekId,
    required this.proyekData,
  });
}

class DeleteTaskById extends TaskEvent {
  final String proyekId;

  DeleteTaskById({required this.proyekId});
}
