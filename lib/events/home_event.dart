import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class LogOutButtonPressedEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}
