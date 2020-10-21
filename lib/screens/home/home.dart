import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_alert/bloc/food_bloc.dart';
import 'package:spoiler_alert/models/food.dart';
import 'package:spoiler_alert/screens/home/add_item.dart';
import 'package:spoiler_alert/services/auth.dart';
import 'package:spoiler_alert/services/database_provider.dart';
import 'package:spoiler_alert/shared/constants.dart';
import 'package:spoiler_alert/events/add_food.dart';
import 'package:spoiler_alert/events/delete_food.dart';
import 'package:spoiler_alert/events/set_foods.dart';
import 'package:spoiler_alert/events/update_food.dart';

class Home extends StatefulWidget {
  const Home(FirebaseUser user, {Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getFoods().then((foodList) {
      BlocProvider.of<FoodBloc>(context).add(SetFoods(foodList));
    });
  }

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
        body: Container(
          child: BlocConsumer<FoodBloc, List<Food>>(
            builder: (BuildContext context, foodList) {
              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  print("foodList: $foodList");

                  Food food = foodList[index];
                  return ListTile(
                      title: Text(food.name, style: TextStyle(fontSize: 30)),
                      subtitle: Text(
                        "Type: ${food.type}\nExpiry date: ${food.expiryDate}",
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () => showFoodDialog(context, food, index));
                },
                itemCount: foodList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.black),
              );
            },
            listener: (BuildContext context, foodList) {},
          ),
        ),
      ),
    );
  }

  showFoodDialog(BuildContext context, Food food, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(food.name),
        content: Text("ID ${food.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddItemForm(food: food, foodIndex: index),
              ),
            ),
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(food.id).then((_) {
              BlocProvider.of<FoodBloc>(context).add(
                DeleteFood(index),
              );
              Navigator.pop(context);
            }),
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
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
