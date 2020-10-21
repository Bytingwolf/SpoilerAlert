import 'package:bloc/bloc.dart';
import 'package:spoiler_alert/bloc/userBloc/user_reg_state.dart';
import 'package:spoiler_alert/events/user_reg_event.dart';
import 'package:spoiler_alert/services/auth.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
  AuthService userRep;

  UserRegBloc() {
    userRep = AuthService();
  }

  @override
  UserRegState get initialState => UserRegInitial();

  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonPressedEvent) {
      try {
        yield UserLoadingState();
        var user = await userRep.registerWithEmailAndPassword(
            event.email, event.password);
        yield UserRegSuccessful(user: user);
      } catch (e) {
        yield UserRegFailure(message: e.toString());
      }
    }
  }
}
