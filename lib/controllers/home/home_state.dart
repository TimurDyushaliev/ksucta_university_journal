abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeFailureState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required this.subjects});

  final List<String> subjects;
}
