import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoiler_alert/bloc/homeBloc/home_state.dart';
import 'package:spoiler_alert/events/home_event.dart';
import 'package:spoiler_alert/services/auth.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthService userRep;

  HomeBloc() {
    this.userRep = AuthService();
  }

  @override
  HomeState get initialState => LogOutInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LogOutButtonPressedEvent) {
      await userRep.signOut();
      yield LogOutSuccessState();
    }
  }
}
