import 'package:rider/authentication/signup_screen.dart';
import 'package:rider/global/global.dart';
import 'package:rider/splashScreen/splash_screen.dart';
import 'package:rider/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog("logging in, please wait...");
      },
    );

    try {
      final UserCredential userCredential =
          await fAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      if (userCredential.user != null) {
        currentFirebaseUser = userCredential.user!;
        Fluttertoast.showToast(msg: "Login successful");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      } else {
        Navigator.pop(context); // Dismiss the progress dialog
        Fluttertoast.showToast(msg: "Error occured during login");
      }
    } catch (error) {
      Navigator.pop(context); // Dismiss the progress dialog
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Login as a driver",
              style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ),
            TextField(
              controller: passwordTextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                validateForm();
              },
              style: ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            TextButton(
              child: const Text(
                "Not have an account! Create one here",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SignUpScreen()));
              },
            )
          ],
        ),
      )),
    );
  }
}
