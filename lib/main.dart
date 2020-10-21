import 'package:spoiler_alert/bloc/authBloc/auth_bloc.dart';
import 'package:spoiler_alert/bloc/authBloc/auth_state.dart';
import 'package:spoiler_alert/screens/home/home.dart';
import 'package:spoiler_alert/screens/home/welcome.dart';
import 'package:spoiler_alert/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_alert/models/user.dart';
import 'screens/authenticate/authenticate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );*/
    return MaterialApp(
        home: BlocProvider(
      create: (context) => AuthBloc(),
      child: App(),
    ));
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          return Authenticate();
        } else if (state is AuthenticatedState) {
          return Home(state.user);
        } else if (state is UnauthenticatedState) {
          return Authenticate();
        }
      },
    );
  }
}
