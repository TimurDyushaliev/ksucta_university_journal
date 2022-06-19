abstract class GroupsState {}

class GroupsInitialState extends GroupsState {}

class GroupsLoadingState extends GroupsState {}

class GroupsFailureState extends GroupsState {}

class GroupsSuccessState extends GroupsState {
  GroupsSuccessState({required this.groups});

  final List<String> groups;
}
