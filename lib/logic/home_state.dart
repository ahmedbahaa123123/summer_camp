// home_state.dart
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeSuccess extends HomeState {}

class HomeLoading extends HomeState {}
