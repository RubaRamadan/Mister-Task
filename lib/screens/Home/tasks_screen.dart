import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Bloc/UsersBloc/user_bloc.dart';
import 'package:task_manager_app/Widgets/tasks_list_view_widget.dart';
import 'package:task_manager_app/screens/Auth/login_screen.dart';
import '../../Bloc/TaskBloc/tasks_bloc.dart';
import '../../Models/task.dart';
import '../../Widgets/reusable_chip_tab.dart';
import '../../local_storage/save_token_in_local_storage.dart';
import 'add_or_update_task_page.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool isDoneClicked=false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<MyTask> tasksList = state.allTasks;
        List<MyTask> doneList = state.doneTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Tasks'),
            actions: [
              IconButton(onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await SharedPreferencesUtil(prefs: prefs).saveTokenLocally('');
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                        (route) => false);
              }, icon: const Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ReusableChipTab(
                    color:  Colors.purple[100],
                    text: '(${state.allTasks.length}) Tasks In Progress',
                    onPressFunc: (){
                      setState(() {
                        isDoneClicked=false;
                      });
                    },
                  ),
                  ReusableChipTab(
                    color:  Colors.green[100],
                    text: '     (${state.doneTasks.length}) Tasks Done     ',
                    onPressFunc: (){
                      setState(() {
                        isDoneClicked=true;
                      });
                    },
                  ),
                ],
              ),
              TasksListViewWidget(
                tasksList: isDoneClicked? doneList : tasksList,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(const SelectUser(userName: ''));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const AddOrUpdateTaskPage(isUpdateTaskPage: false),
                  ));
            },
            tooltip: 'Add new task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
