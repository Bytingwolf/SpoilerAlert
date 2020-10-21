import 'package:spoiler_alert/bloc/food_bloc.dart';
import 'package:spoiler_alert/screens/authenticate/authenticate.dart';
import 'package:spoiler_alert/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoiler_alert/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either home or authenticate widget.
    if (user == null) {
      return Authenticate();
    } else {
      //return Home();
    }
  }
}
