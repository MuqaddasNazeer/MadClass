import 'package:flutter/material.dart';

class Gratitude extends StatefulWidget {
  final int? radioGroupValue; // Make it nullable
  Gratitude({Key? key, required this.radioGroupValue}) : super(key: key);
  @override
  _GratitudeState createState() => _GratitudeState(radioGroupValue);
}

class _GratitudeState extends State<Gratitude> {
  int? radioGroupValue;
  List<String> _gratitudeList = ['Family', 'Friends', 'Coffee'];

  _GratitudeState(this.radioGroupValue);

  void _radioOnChanged(int? index) {
    setState(() {
      radioGroupValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gratitude'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context, radioGroupValue);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: _gratitudeList
                .asMap()
                .entries
                .map(
                  (entry) => RadioListTile(
                    title: Text(entry.value),
                    value: entry.key,
                    groupValue: radioGroupValue,
                    onChanged: (index) => _radioOnChanged(index),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
