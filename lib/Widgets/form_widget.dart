import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/Widgets/reusable_button.dart';
import 'package:task_manager_app/Widgets/reusable_text_field.dart';
import 'package:task_manager_app/screens/Home/tasks_screen.dart';
import 'package:uuid/uuid.dart';

import '../Bloc/TaskBloc/tasks_bloc.dart';
import '../Bloc/UsersBloc/user_bloc.dart';
import '../Core/functions.dart';
import '../Models/task.dart';
import '../screens/Home/users_screen.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, this.task, required this.isUpdateTaskPage});
  final MyTask? task;
  final bool isUpdateTaskPage;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdateTaskPage) {
      titleEditingController.text = widget.task!.title;
      descriptionEditingController.text = widget.task!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReusableTextField(
                      textEditingController: titleEditingController,
                      onChangedFunc: (val) {},
                      isPasswordField: false,
                      validationFunc: (val) {
                        InputValidator.validate(val);
                      },
                      hint: 'Task title',
                      maxLines: 1,
                      minLines: 1,
                    ),
                    ReusableTextField(
                      textEditingController: descriptionEditingController,
                      onChangedFunc: (val) {},
                      isPasswordField: false,
                      validationFunc: (val) {
                        InputValidator.validate(val);
                      },
                      hint: 'Task title',
                      minLines: 6,
                      maxLines: 6,
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<UserBloc>(context).add(GetUsers());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UsersScreen(),
                            ));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: widget.isUpdateTaskPage
                                    ? Colors.purple
                                    : state.selectedManagerName == ''
                                        ? Colors.grey
                                        : Colors.purple),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: widget.isUpdateTaskPage
                              ? Text(
                                  'Old manager is ${widget.task!.manager} Click here to select new manager',
                                  textAlign: TextAlign.center,
                                )
                              : state.selectedManagerName == ''
                                  ? const Text('Click here to select manager')
                                  : Text(
                                      '${state.selectedManagerName} is the manager',
                                      style: const TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold),
                                    ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableButton(
                            btnText: widget.isUpdateTaskPage ? 'Update' : 'Add',
                            onTapFunction: () {
                              if (_formKey.currentState!.validate()) {
                                var uuid = const Uuid();
                                final task = MyTask(
                                    id: uuid.v1(),
                                    title: titleEditingController.text,
                                    description:
                                        descriptionEditingController.text,
                                    isChecked: widget.isUpdateTaskPage
                                        ? widget.task!.isChecked
                                        : false,
                                    isDeleted: widget.isUpdateTaskPage
                                        ? widget.task!.isDeleted
                                        : false,
                                    manager: state.selectedManagerName);
                                if (widget.isUpdateTaskPage) {
                                  BlocProvider.of<TasksBloc>(context).add(
                                      UpdateTask(
                                          task: widget.task!, newTask: task));
                                } else {
                                  BlocProvider.of<TasksBloc>(context)
                                      .add(AddTask(task: task));
                                }
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const TasksScreen(),
                                    ),
                                    (route) => false);
                              }
                            }),
                        const SizedBox(
                          width: 20,
                        ),
                        widget.isUpdateTaskPage
                            ? ReusableDeleteButton(
                                btnText: 'Delete',
                                onTapFunction: () {
                                  BlocProvider.of<TasksBloc>(context)
                                      .add(DeleteTask(task: widget.task!));
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TasksScreen(),
                                      ),
                                      (route) => false);
                                })
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
