import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/services/hive_provider.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  void fetch() {
    emit(HomeLoadingState());
    emit(HomeSuccessState(subjects: HiveProvider.getSubjects()));
  }

  Future<void> addSubject(String name) async {
    emit(HomeLoadingState());
    await HiveProvider.addSubject(name);
    emit(HomeSuccessState(subjects: HiveProvider.getSubjects()));
  }

  Future<void> deleteSubject(int index) async {
    emit(HomeLoadingState());
    await HiveProvider.deleteSubject(index);
    emit(HomeSuccessState(subjects: HiveProvider.getSubjects()));
  }
}
