import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_university_journal/models/student_model.dart';

class HiveProvider {
  static late Box<String> _subjectsBox;
  static late Box<List<String>> _groupsBox;
  static late Box<List<dynamic>> _studentsBox;

  static Future<void> init() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    _subjectsBox = await Hive.openBox<String>('subjects');
    _groupsBox = await Hive.openBox<List<String>>('groups');
    _studentsBox = await Hive.openBox<List<dynamic>>('students');
  }

  static Future<int> addSubject(String name) {
    return _subjectsBox.add(name);
  }

  static List<String> getSubjects() {
    return _subjectsBox.values.toList();
  }

  static Future<void> deleteSubject(int index) {
    return _subjectsBox.deleteAt(index);
  }

  static Future<void> addGroup(String subjectName, String groupName) {
    final hash = subjectName.hashCode.toString();
    final groups = getGroups(subjectName)?..add(groupName);

    if (groups != null) {
      return _groupsBox.put(hash, groups);
    } else {
      return _groupsBox.put(hash, [groupName]);
    }
  }

  static List<String>? getGroups(String subjectName) {
    return _groupsBox.get(subjectName.hashCode.toString());
  }

  static Future<void> deleteGroup(String subjectName, int groupIndex) {
    final hash = subjectName.hashCode.toString();
    final groups = getGroups(subjectName)!..removeAt(groupIndex);
    return _groupsBox.put(hash, groups);
  }

  static Future<void> addStudent(String groupName, StudentModel student) {
    final hash = groupName.hashCode.toString();
    final students = getStudents(groupName)?..add(student);
    if (students != null) {
      return _studentsBox.put(
          hash, students.map((student) => student.toJson()).toList());
    } else {
      return _studentsBox.put(hash, [student.toJson()]);
    }
  }

  static Future<void> replaceStudent(String groupName, StudentModel student) {
    final hash = groupName.hashCode.toString();
    final students = getStudents(groupName)!;
    final index =
        students.indexWhere((element) => element.name == student.name);
    students
      ..removeAt(index)
      ..insert(index, student);
    return _studentsBox.put(
        hash, students.map((student) => student.toJson()).toList());
  }

  static List<StudentModel>? getStudents(String groupName) {
    final hash = groupName.hashCode.toString();
    final json = _studentsBox.get(hash);
    return json?.map((json) => StudentModel.fromJson(json)).toList();
  }

  static Future<void> deleteStudent(String groupName, int studentIndex) {
    final hash = groupName.hashCode.toString();
    final students = getStudents(groupName)!..removeAt(studentIndex);
    return _studentsBox.put(
        hash, students.map((student) => student.toJson()).toList());
  }
}
