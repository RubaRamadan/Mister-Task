import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/Bloc/LoginBloc/login_bloc.dart';
import 'package:task_manager_app/Bloc/UsersBloc/user_bloc.dart';
import 'package:task_manager_app/screens/Auth/login_screen.dart';
import 'package:task_manager_app/screens/Home/tasks_screen.dart';
import 'package:task_manager_app/screens/splach_screen.dart';
import 'Bloc/TaskBloc/tasks_bloc.dart';
import 'local_storage/save_token_in_local_storage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var token;
  getTokenFromLocalStorage()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token=await SharedPreferencesUtil(prefs: prefs).getTokenFromPref();
  }
  @override
  void initState() {
    getTokenFromLocalStorage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const SplashScreen()// token==''?const LoginScreen():const TasksScreen(),
      ),
    );
  }
}

