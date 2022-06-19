enum StudentAttendStatus { yes, no, unknown }

class StudentModel {
  StudentModel({
    required this.name,
    required this.status,
  });

  final String name;
  final StudentAttendStatus status;

  factory StudentModel.fromJson(Map<dynamic, dynamic> json) {
    return StudentModel(
      name: json['name'] ?? '',
      status: StudentAttendStatus.values[json['status'] ?? 2],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': StudentAttendStatus.values.indexOf(status),
    };
  }

  StudentModel copyWith({String? name, StudentAttendStatus? status}) {
    return StudentModel(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
