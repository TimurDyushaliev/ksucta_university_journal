import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/groups/groups_state.dart';
import 'package:simple_university_journal/services/hive_provider.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(GroupsInitialState());

  late String subjectName;

  void fetch(String subjectName) {
    this.subjectName = subjectName;
    emit(GroupsLoadingState());
    final groups = HiveProvider.getGroups(subjectName);
    emit(GroupsSuccessState(groups: groups ?? []));
  }

  Future<void> addGroup(String name) async {
    emit(GroupsLoadingState());
    await HiveProvider.addGroup(subjectName, name);
    final groups = HiveProvider.getGroups(subjectName);
    emit(GroupsSuccessState(groups: groups ?? []));
  }

  Future<void> deleteGroup(int groupIndex) async {
    emit(GroupsLoadingState());
    await HiveProvider.deleteGroup(subjectName, groupIndex);
    final groups = HiveProvider.getGroups(subjectName);
    emit(GroupsSuccessState(groups: groups ?? []));
  }
}
