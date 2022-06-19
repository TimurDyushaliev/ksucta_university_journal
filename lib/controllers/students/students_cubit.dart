import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/students/students_state.dart';
import 'package:simple_university_journal/models/student_model.dart';
import 'package:simple_university_journal/services/hive_provider.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(StudentsInitialState());

  late String groupName;

  void fetch(String groupName) {
    this.groupName = groupName;
    emit(StudentsLoadingState());
    final students = HiveProvider.getStudents(groupName);
    emit(StudentsSuccessState(students: students ?? []));
  }

  Future<void> addStudent(String name) async {
    emit(StudentsLoadingState());
    await HiveProvider.addStudent(
        groupName,
        StudentModel(
          name: name,
          status: StudentAttendStatus.unknown,
        ));
    final students = HiveProvider.getStudents(groupName);
    emit(StudentsSuccessState(students: students ?? []));
  }

  Future<void> deleteStudent(int studentIndex) async {
    emit(StudentsLoadingState());
    await HiveProvider.deleteStudent(groupName, studentIndex);
    final students = HiveProvider.getStudents(groupName);
    emit(StudentsSuccessState(students: students ?? []));
  }

  Future<void> replaceStudent(StudentModel student) async {
    emit(StudentsLoadingState());
    await HiveProvider.replaceStudent(groupName, student);
    final students = HiveProvider.getStudents(groupName);
    emit(StudentsSuccessState(students: students ?? []));
  }
}
