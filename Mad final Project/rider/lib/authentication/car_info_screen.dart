import 'package:rider/global/global.dart';
import 'package:rider/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
 

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["ride-x", "ride-go", "bike"];
  String? selectedCartype;

  saveCarInfo()
  {
    final DateTime now = DateTime.now();
    Map driverCarInfoMap = 
            {
              "car_color": carColorTextEditingController.text.trim(),
              "car_number": carNumberTextEditingController.text.trim(),
              "car_model": carModelTextEditingController.text.trim(),
              "type": selectedCartype,
              "createdAt": now.toUtc().toString(), // Add createdAt attribute
              "updatedAt": now.toUtc().toString(), // Add updatedAt attribute
            };

            DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
            driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

            Fluttertoast.showToast(msg: "Car details has been saved");
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(height: 24,),
          Padding(padding: const EdgeInsets.all(20.0),
          child: Image.asset("images/logo.png"),
          ),
        
           const SizedBox(height: 10,),
          
              const Text("Write Car Details",
              style: TextStyle(
                fontSize: 26,
                color: Colors.grey,
                fontWeight: FontWeight.bold
              ),
              ),
        
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
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
        
              TextField(
                controller: carNumberTextEditingController,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
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
        
              TextField(
                controller: carColorTextEditingController,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
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

              const SizedBox(height: 10,),
              DropdownButton(
                iconSize: 26,
                dropdownColor: Colors.black,
                hint: const Text(
                  "Please choose car type",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                ),
                value: selectedCartype,
                onChanged: (newValue){
                  setState(() {
                     selectedCartype = newValue.toString();
                  });
                },
                items: carTypesList.map((car){
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    ),
                    value: car,
                  );
                }).toList(),
              ),

               const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: ()
              {
                  if(carColorTextEditingController.text.isNotEmpty && carNumberTextEditingController.text.isNotEmpty && carModelTextEditingController.text.isNotEmpty && selectedCartype != null)
                  {
                    saveCarInfo();
                  }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreenAccent
              ),
              child: const Text(
                "Save Now",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18
                ),
              ),
            )
              ],),
        )),
      
    );
  }
}