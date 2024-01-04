import 'dart:async';
import 'package:flutter/material.dart';
import 'package:users/authentication/login_screen.dart';
import 'package:users/global/global.dart';
import 'package:users/mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  // For how much time this screen appears
  
  startTimer(){
    Timer(const Duration(seconds: 3), () async{
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
      

    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.jpg"),
              const SizedBox(height: 10,),
              const Text("Togoride",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
              ),
            ],
            ),)
      ),
    );
  }
}
