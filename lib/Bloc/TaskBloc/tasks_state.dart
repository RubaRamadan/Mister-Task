part of 'tasks_bloc.dart';

 class TasksState extends Equatable{
   final List<MyTask> allTasks;
   final List<MyTask> doneTasks;
   const TasksState({
     this.allTasks=const <MyTask>[],
     this.doneTasks=const <MyTask>[],
 });


  @override
  List<Object?> get props => [allTasks,doneTasks];

 Map<String,dynamic> toMap(){
   return {
     'allTasks':allTasks.map((e) => e.toMap()).toList(),
     'doneTasks':doneTasks.map((e) => e.toMap()).toList(),
   };
 }


 factory TasksState.fromMap(Map<String,dynamic> map){
   return TasksState(
     allTasks: List<MyTask>.from(map['allTasks']?.map((e)=>MyTask.fromMap(e))),
     doneTasks: List<MyTask>.from(map['doneTasks']?.map((e)=>MyTask.fromMap(e))),
   );
 }
 }
