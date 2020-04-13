import 'package:flutter/material.dart';
import 'package:spoiler_alert/screens/home/add_item.dart';
import 'package:spoiler_alert/services/auth.dart';
import 'package:spoiler_alert/shared/constants.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('SpoilerAlert'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
    );
  }

  void choiceAction(String choice) async {
    if (choice == Constants.signOut) {
      await _auth.signOut();
    } else if (choice == Constants.addFood) {
      var addItem = new AddItem();
    }
  }
}
