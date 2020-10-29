import 'package:flutter/material.dart';
import 'package:spoiler_alert/shared/constants.dart';
import 'package:intl/intl.dart';

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
  //final Food food;
  //final int foodIndex;

  //AddItemForm({this.food, this.foodIndex});

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
  String _expiryDateString = '';
  final DateFormat dateOnlyFormat = DateFormat('yyyy.MM.dd');

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
            Text(_expiryDate == null
                ? "Choose expiry date"
                : _expiryDate.toString()),
            RaisedButton(
                child: Text('Pick a date'),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  ).then((date) {
                    setState(() {
                      _expiryDate = date;
                      dateOnlyFormat.format(_expiryDate);
                      dateOnlyFormat.parse(_expiryDateString);
                    });
                  });
                }),
            Row(children: [
              //widget.food == null ?
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        Navigator.pop(context);
                      }

                      _formKey.currentState.save();

                      /*Food food = Food(
                            name: _foodName,
                            type: _foodType,
                            expiryDate: _expiryDateString,
                          );

                          DatabaseProvider.db.insert(food).then((storedFood) =>
                              BlocProvider.of<FoodBloc>(context).add(
                                AddFood(storedFood),
                              ));*/
                    },
                    child: Text('Submit'),
                  ))
              /*: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                            Navigator.pop(context);
                          }

                          _formKey.currentState.save();

                          Food food = Food(
                            name: _foodName,
                            type: _foodType,
                            expiryDate: _expiryDateString,
                          );

                          DatabaseProvider.db.update(widget.food).then(
                              (storedFood) =>
                                  BlocProvider.of<FoodBloc>(context).add(
                                    UpdateFood(widget.foodIndex, food),
                                  ));
                        },
                        child: Text('Update'),
                      ))*/
              ,
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
