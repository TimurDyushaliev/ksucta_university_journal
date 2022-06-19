import 'package:flutter/material.dart';
import 'package:simple_university_journal/resources/strings.dart';

enum FromPage { home, groups, students }

class AddListItemWidget extends StatelessWidget {
  AddListItemWidget({
    Key? key,
    required this.onDone,
    this.fromPage = FromPage.home,
  }) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();
  final Function(String) onDone;
  final FromPage fromPage;

  String get _title {
    switch (fromPage) {
      case FromPage.home:
        return StringResource.home.newSubject;
      case FromPage.groups:
        return StringResource.groups.newGroup;
      case FromPage.students:
        return StringResource.students.newStudent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        textEditingController.clear();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(_title),
            content: TextField(
              controller: textEditingController,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            actions: [
              TextButton(
                onPressed: () {
                  onDone(textEditingController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  StringResource.home.add.toUpperCase(),
                ),
              ),
            ],
          ),
        );
      },
      child: Text(
        StringResource.home.add.toUpperCase(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
