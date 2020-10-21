import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_alert/bloc/loginBloc/login_state.dart';
import 'package:spoiler_alert/events/login_event.dart';
import 'package:spoiler_alert/services/auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthService userRep;

  LoginBloc() {
    this.userRep = AuthService();
  }

  @override
  LoginInitialState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      try {
        yield LoginLoadingState();
        var user = await userRep.signInWithEmailAndPassword(
            event.email, event.password);
        yield LoginSuccessfulState(user: user);
      } catch (e) {
        yield LoginFailureState(message: e.toString());
      }
    }
  }
}
