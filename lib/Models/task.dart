import 'package:equatable/equatable.dart';

class MyTask extends Equatable{
  final String id;
  final String title;
  final String description;
  final bool isChecked;
  final bool isDeleted;
  final String manager;

  const MyTask({required this.id, required this.title, required this.description, required this.isChecked, required this.isDeleted, required this.manager});

  MyTask copyWith({
      String? id,
      String? title,
      String? description,
      bool? isChecked,
      bool? isDeleted,
      String? manager
}){
    return MyTask(
        id: id??this.id,
        title:title??this.title,
        description: description??this.description,
        isChecked: isChecked??this.isChecked,
        isDeleted: isDeleted??this.isDeleted,
        manager: manager??this.manager,
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'description':description,
      'isChecked':isChecked,
      'isDeleted':isDeleted,
      'manager':manager,
    };
  }

  factory MyTask.fromMap( Map<String,dynamic> map){
    return MyTask(id: map['id'],title: map['title'], description: map['description'], isChecked: map['isChecked'],
        isDeleted: map['isDeleted'],manager: map['manager']);
  }

  @override
  List<Object?> get props => [id,title,description,isChecked,isDeleted];

}