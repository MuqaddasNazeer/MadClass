import 'dart:async';
import 'package:rider/authentication/login_screen.dart';
import 'package:rider/global/global.dart';
import 'package:rider/mainScreens/main_screen.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
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
              Image.asset("images/logo.png"),
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
