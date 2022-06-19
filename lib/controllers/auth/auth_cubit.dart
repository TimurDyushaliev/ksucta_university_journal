import 'package:bloc/bloc.dart';
import 'package:simple_university_journal/resources/strings.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  void validate(String value) {
    emit(AuthValidatingState());

    if (value != StringResource.auth.existingUserName) {
      emit(AuthFailureState(message: StringResource.auth.noSuchUser));
      return;
    }

    emit(AuthSuccessState());
  }
}
