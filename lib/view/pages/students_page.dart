import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/students/students_cubit.dart';
import 'package:simple_university_journal/controllers/students/students_state.dart';
import 'package:simple_university_journal/models/student_model.dart';
import 'package:simple_university_journal/resources/strings.dart';
import 'package:simple_university_journal/view/widgets/add_list_item_widget.dart';
import 'package:simple_university_journal/view/widgets/list_tile_widget.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  late StudentsCubit cubit;

  @override
  void initState() {
    cubit = context.read<StudentsCubit>();
    cubit.fetch(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          AddListItemWidget(
            fromPage: FromPage.students,
            onDone: (value) {
              if (value.isNotEmpty) {
                cubit.addStudent(value);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<StudentsCubit, StudentsState>(
        builder: (context, state) {
          if (state is StudentsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentsSuccessState) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTileWidget(
                  key: ValueKey(index),
                  color: _getStudentStatusColor(student.status),
                  title: student.name,
                  displayTrailing: false,
                  onDelete: () {
                    cubit.deleteStudent(index);
                  },
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(StringResource.students.markStudent),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            2,
                            (index) => Padding(
                              padding:
                                  EdgeInsets.only(bottom: index == 0 ? 15 : 0),
                              child: Container(
                                color: index == 0
                                    ? Colors.green[50]
                                    : Colors.red[50],
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        cubit.replaceStudent(
                                          student.copyWith(
                                            status: index == 0
                                                ? StudentAttendStatus.yes
                                                : StudentAttendStatus.no,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        index == 0
                                            ? StringResource.students.attend
                                            : StringResource.students.notAttend,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      index == 0 ? Icons.check : Icons.close,
                                      color: index == 0
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Color? _getStudentStatusColor(StudentAttendStatus status) {
    switch (status) {
      case StudentAttendStatus.yes:
        return Colors.green;
      case StudentAttendStatus.no:
        return Colors.red;
      case StudentAttendStatus.unknown:
        return null;
    }
  }
}
