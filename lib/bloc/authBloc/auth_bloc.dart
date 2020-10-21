import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:spoiler_alert/events/auth_event.dart';
import 'package:spoiler_alert/services/auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService userRep;

  AuthBloc() {
    this.userRep = AuthService();
  }

  @override
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStartedEvent) {
      try {
        var isSignedIn = await userRep.isSignedIn();
        if (isSignedIn) {
          var user = await AuthService().getCurrentUser();
          yield AuthenticatedState(user: user);
        } else {
          yield UnauthenticatedState();
        }
      } catch (e) {
        yield UnauthenticatedState();
      }
    }
  }
}
