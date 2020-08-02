import 'package:flutter/material.dart';
import 'package:spoiler_alert/screens/home/home.dart';
import 'package:spoiler_alert/shared/constants.dart';
import 'package:date_field/date_field.dart';

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
  String _foodType = 'Best Before';
  DateTime _expiryDate = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (_expiryDate != null && _expiryDate != DateTime.now()) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration:
                  textInputDecoration.copyWith(hintText: 'Name of the food'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter a valid name.' : null,
              onChanged: (val) {
                setState(() => _foodName = val);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownButton<String>(
              value: _foodType,
              elevation: 30,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.blueAccent[400],
              ),
              onChanged: (String val) {
                setState(() {
                  _foodType = val;
                });
              },
              items: <String>['Best Before', 'Frozen', 'Use By']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10.0,
            ),
            DateTimeField(
              onDateSelected: (DateTime value) {
                setState(() {
                  _expiryDate = value;
                });
              },
              selectedDate: _expiryDate,
            ),
            Row(children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
