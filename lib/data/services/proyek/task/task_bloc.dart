import 'package:bloc/bloc.dart';
import 'package:drawer/data/model/task_proyek.dart';
import 'package:drawer/data/services/proyek/task/task_service.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskService taskService;

  TaskBloc({required this.taskService}) : super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetTaskById>((event, emit) async {
      emit(TaskLoading());
      try {
        final user = await taskService.getTaskById(event.taskId);
        emit(TaskByIdLoaded(user));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
    on<StoreTask>((event, emit) async {
      emit(TaskStoring());
      try {
        final Map<String, String> taskData =
            event.taskData.map((key, value) => MapEntry(key, value.toString()));
        await taskService.storeTask(taskData);
        emit(TaskStored());
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<UpdateTaskById>((event, emit) async {
      emit(TaskLoading());
      try {
        final Map<String, String> proyekData = event.proyekData
            .map((key, value) => MapEntry(key, value.toString()));
        await taskService.updateTaskById(event.proyekId, proyekData);
        emit(TaskUpdated());
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<DeleteTaskById>((event, emit) async {
      emit(TaskLoading());
      try {
        await taskService.deleteTasksById(event.proyekId);
        emit(TaskDeleted());
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}
