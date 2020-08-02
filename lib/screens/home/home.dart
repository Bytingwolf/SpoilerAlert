import 'package:flutter/material.dart';
import 'package:spoiler_alert/screens/home/add_item.dart';
import 'package:spoiler_alert/services/auth.dart';
import 'package:spoiler_alert/shared/constants.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Are you sure?'),
                  content: new Text('Do you want to exit an App'),
                  actions: <Widget>[
                    SizedBox(height: 30),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(true),
                      child: Text("YES"),
                    ),
                    SizedBox(height: 30),
                    new GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Text("NO"),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ) ??
              false;
        },
        child: new Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Text('SpoilerAlert'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (choice) => choiceAction(choice, context),
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
        ));
  }

  void choiceAction(String choice, BuildContext context) async {
    if (choice == Constants.signOut) {
      await _auth.signOut();
    } else if (choice == Constants.addFood) {
      Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => AddItem()),
      );
    } else if (choice == Constants.editFood) {
      /*Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => EditItem()),
      );*/
    } else if (choice == Constants.settings) {
      /*Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => Settings()),
      );*/
    }
  }
}
