import 'package:flutter/material.dart';
import 'package:spoiler_alert/screens/home/home.dart';
import 'package:spoiler_alert/shared/constants.dart';

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add a food item';

    return new Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: AddItemForm(),
    );
  }
}

class AddItemForm extends StatefulWidget {
  @override
  AddItemFormState createState() {
    return AddItemFormState();
  }
}

class AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  String _foodName = '';
  String _foodType = '';
  DateTime _expiryDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration:
                textInputDecoration.copyWith(hintText: 'Name of the food'),
            validator: (val) =>
                val.isEmpty ? 'Please enter a valid name.' : null,
            onChanged: (val) {
              setState(() => _foodName = val);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                /*Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => Home()),
                );*/
              },
              child: Text('Cancel'),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    Navigator.pop(context);
                    /*Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => Home()),
                    );*/
                  }
                },
                child: Text('Submit'),
              )),
        ],
      ),
    );
  }
}
