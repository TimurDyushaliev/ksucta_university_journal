import 'package:simple_university_journal/models/student_model.dart';

abstract class StudentsState {}

class StudentsInitialState extends StudentsState {}

class StudentsLoadingState extends StudentsState {}

class StudentsFailureState extends StudentsState {}

class StudentsSuccessState extends StudentsState {
  StudentsSuccessState({required this.students});

  final List<StudentModel> students;
}
