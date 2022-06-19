abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthValidatingState extends AuthState {}

class AuthFailureState extends AuthState {
  AuthFailureState({this.message});
  final String? message;
}

class AuthSuccessState extends AuthState {}
