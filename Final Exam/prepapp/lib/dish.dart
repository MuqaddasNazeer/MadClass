import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DishPage extends StatefulWidget {
  @override
  _DishPageState createState() => _DishPageState();
}

class _DishPageState extends State<DishPage> {
  String dishId = '';
  String dishName = '';
  double dishPrice = 0.0;
  bool isAvailable = false;
  String dishType = '';
  String restaurantId = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dish'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Dish ID'),
              onChanged: (value) {
                setState(() {
                  dishId = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Dish Name'),
              onChanged: (value) {
                setState(() {
                  dishName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Dish Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  dishPrice = double.parse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: isAvailable,
                  onChanged: (value) {
                    setState(() {
                      isAvailable = value ?? false;
                    });
                  },
                ),
                Text('Available'),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Dish Type'),
              onChanged: (value) {
                setState(() {
                  dishType = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Restaurant ID'),
              onChanged: (value) {
                setState(() {
                  restaurantId = value;
                });
              },
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                await _addDishToFirestore();
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 40.0),
            Image.asset(
              'image/img1.png', // Update the path to your image
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addDishToFirestore() async {
  try {
    await _firestore.collection('dishes').add({
      'dishId': dishId,
      'dishName': dishName,
      'dishPrice': dishPrice,
      'isAvailable': isAvailable,
      'dishType': dishType,
      'restaurantId': restaurantId,
    });

    // Clear the form fields after successful submission
    _clearFormFields();

    print('Dish details added to Firestore successfully!');
  } catch (e) {
    print('Error adding dish details to Firestore: $e');
  }
}

void _clearFormFields() {
  setState(() {
    dishId = '';
    dishName = '';
    dishPrice = 0.0;
    isAvailable = false;
    dishType = '';
    restaurantId = '';
  });
}
}
