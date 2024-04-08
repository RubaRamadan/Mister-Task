import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/TaskBloc/tasks_bloc.dart';
import '../../Models/task.dart';
import '../../Widgets/form_widget.dart';

class AddOrUpdateTaskPage extends StatelessWidget {
  const AddOrUpdateTaskPage(
      {super.key, this.task, required this.isUpdateTaskPage});
  final MyTask? task;
  final bool isUpdateTaskPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdateTaskPage ? 'Edit Task' : 'Add New Task'),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocConsumer<TasksBloc, TasksState>(
          builder: (context, state) {
            return FormWidget(isUpdateTaskPage:isUpdateTaskPage,task:isUpdateTaskPage?task:null);
          },
          listener: (context, state) {
          },
        ));
  }
}
