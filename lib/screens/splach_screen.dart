import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/screens/Auth/login_screen.dart';

import '../local_storage/save_token_in_local_storage.dart';
import 'Home/tasks_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate=false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple.withOpacity(0.1),
        child:   Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                bottom:animate? 300 :-170,
                child: const Logo())
          ],
        ),
      ),
    );
  }

  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {animate=true;});
    var token;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      token=await SharedPreferencesUtil(prefs: prefs).getTokenFromPref();

    await Future.delayed(const Duration(milliseconds: 1000));
    // ignore: use_build_context_synchronously
    if(token==''){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false);
    } else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const TasksScreen()),
              (Route<dynamic> route) => false);
    }
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 150,
          width: 150,
          child: Image.asset('assets/images/logo.png')),
    );
  }
}