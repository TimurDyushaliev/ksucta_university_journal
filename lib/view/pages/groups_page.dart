import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/groups/groups_cubit.dart';
import 'package:simple_university_journal/controllers/groups/groups_state.dart';
import 'package:simple_university_journal/controllers/students/students_cubit.dart';
import 'package:simple_university_journal/view/pages/students_page.dart';
import 'package:simple_university_journal/view/widgets/add_list_item_widget.dart';
import 'package:simple_university_journal/view/widgets/list_tile_widget.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  late GroupsCubit cubit;

  @override
  void initState() {
    cubit = context.read<GroupsCubit>();
    cubit.fetch(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        actions: [
          AddListItemWidget(
            fromPage: FromPage.groups,
            onDone: (value) {
              if (value.isNotEmpty) {
                cubit.addGroup(value);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GroupsSuccessState) {
            return ListView.builder(
              itemCount: state.groups.length,
              itemBuilder: (context, index) {
                final group = state.groups[index];
                return ListTileWidget(
                  key: ValueKey(index),
                  title: group,
                  onDelete: () {
                    cubit.deleteGroup(index);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => StudentsCubit(),
                          child: StudentsPage(
                            title: group,
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
}
