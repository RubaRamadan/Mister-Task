import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:task_manager_app/Models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<DoneTask>(_onDoneTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    List<MyTask> doneTasks=state.doneTasks;
    emit(TasksState(
        allTasks: List.from(state.allTasks)..add(event.task),
        doneTasks: doneTasks
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final task = event.task;
    if(event.task.isChecked){
      List<MyTask> allTasks=state.allTasks;
      final int index = state.doneTasks.indexOf(task);
      List<MyTask> doneTasksAfterRemoveThis = List.from(state.doneTasks)..remove(task);
      emit(TasksState(
          doneTasks: List.from(doneTasksAfterRemoveThis)..insert(index, event.newTask),
          allTasks: allTasks
      ));
    }else{
      List<MyTask> doneTask=state.doneTasks;
      final int index = state.allTasks.indexOf(task);
    List<MyTask> allTasksAfterRemoveThis = List.from(state.allTasks)..remove(task);
    emit(TasksState(
        allTasks: List.from(allTasksAfterRemoveThis)..insert(index, event.newTask),
        doneTasks: doneTask
    ));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
     if(event.task.isChecked){
       List<MyTask> allTasks=state.allTasks;
       emit(TasksState(
           doneTasks: List.from(state.doneTasks)..remove(event.task),
           allTasks: allTasks
       ));
     }
     else{
       List<MyTask> doneTasks=state.doneTasks;
      emit(TasksState(
          allTasks: List.from(state.allTasks)..remove(event.task),
          doneTasks: doneTasks));
    }
  }

  void _onDoneTask(DoneTask event, Emitter<TasksState> emit) {
    emit(
        TasksState(
            allTasks: List.from(state.allTasks)..remove(event.task),
            doneTasks: List.from(state.doneTasks)..add(event.task.copyWith(isChecked:true))
        )
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    // implement fromJson
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    // implement toJson
    return state.toMap();
  }
}
