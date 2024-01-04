// HomeScreen.dart
import 'package:flutter/material.dart';
import 'dish.dart';
import 'dish_list_page.dart'; // Import DishListPage

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Add Dish Page
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DishPage(),
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Add Dish",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to View Dish Page (DishListPage)
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DishListPage(),
                ));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "View Dish",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),),
);
}
}