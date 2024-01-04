import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DishListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dish List'),
        backgroundColor: Colors.deepPurple, // Changed AppBar color
      ),
      body: _buildDishList(),
      backgroundColor: Colors.grey[200], // Set background color
    );
  }

  Widget _buildDishList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('dishes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var dishes = snapshot.data!.docs;
        List<Widget> dishWidgets = [];
        for (var dish in dishes) {
          var dishData = dish.data() as Map<String, dynamic>;
          var dishWidget = Card( // Wrap ListTile with Card for a neater look
            elevation: 4.0,
            margin: EdgeInsets.all(8.0), // Add some margin
            child: ListTile(
              title: Text(
                dishData['dishName'],
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text style
              ),
              subtitle: Text('Price: \$${dishData['dishPrice']}'),
              leading: CircleAvatar( // Use CircleAvatar for images
                backgroundImage: AssetImage('images/img2.png'),
              ),
              trailing: Icon(Icons.arrow_forward_ios), // Add an icon at the end
            ),
          );

          dishWidgets.add(dishWidget);
        }

        return ListView(
          children: dishWidgets,
        );
     },
);
}
}