import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/authentication/login_screen.dart';
import 'package:users/global/global.dart';
import 'package:users/splashScreen/splash_screen.dart';
import 'package:users/widgets/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  
  //get now => null;

   validateForm()
  {
    if(nameTextEditingController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atleast 3 characters");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not valid");
    }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone number is required");
    }
     else if(passwordTextEditingController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    }
    else{
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext c) {
      return ProgressDialog("Processing, please wait...");
    },
  );

// Add to firebase

  try {
    final UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    );

    if (userCredential.user != null) {
      final DateTime now = DateTime.now();
      Map<String, dynamic> userMap = {
        "id": userCredential.user!.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "createdAt": now.toUtc().toString(), // Add createdAt attribute
        "updatedAt": now.toUtc().toString(), // Add updatedAt attribute
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("users");
      await driversRef.child(userCredential.user!.uid).set(userMap);

      currentFirebaseUser = userCredential.user!;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    } else {
      Navigator.pop(context); // Dismiss the progress dialog
      Fluttertoast.showToast(msg: "Account has not been created");
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
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
        
            const SizedBox(height: 10,),
         
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.jpg"),
            ),
        
            const SizedBox(height: 10,),
        
            const Text("Register as a user",
            style: TextStyle(
              fontSize: 26,
              color: Colors.grey,
              fontWeight: FontWeight.bold
            ),
            ),
        
        // Name field
            TextField(
              controller: nameTextEditingController,
              style: const TextStyle(
                color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Name",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              ),
            ),

      // Email field
            TextField(
              controller: emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Email",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              ),
            ),

      // Phone field
            TextField(
              controller: phoneTextEditingController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "Phone",
                hintText: "Phone",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              ),
            ),

    // Password field
            TextField(
              controller: passwordTextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(
                color: Colors.grey
              ),
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Password",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
                ),
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 10
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              ),
            ),

            const SizedBox(height: 20,),
      
      // Sign up button
      
            ElevatedButton(
              onPressed: ()
              {
                  validateForm();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreenAccent
              ),
              child: const Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18
                ),
              ),
            ),

            TextButton(
              child: const Text(
                "Already have an account? Login here",
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
              },
            )

          ],),
        )
        ),
    );
  }
}