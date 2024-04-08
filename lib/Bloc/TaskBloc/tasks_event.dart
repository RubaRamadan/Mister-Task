part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable{
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class AddTask extends TasksEvent{
  final MyTask task;

  const AddTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TasksEvent{
  final MyTask task;
  final MyTask newTask;

  const UpdateTask({required this.newTask, required this.task});

  @override
  List<Object?> get props => [task,newTask];
}

class DeleteTask extends TasksEvent{
  final MyTask task;

  const DeleteTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class DoneTask extends TasksEvent{
  final MyTask task;

  const DoneTask({required this.task});

  @override
  List<Object?> get props => [task];
}

