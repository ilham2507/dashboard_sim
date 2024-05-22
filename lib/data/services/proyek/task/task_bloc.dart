import 'package:bloc/bloc.dart';
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
  }
}
