import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/groups/groups_cubit.dart';
import 'package:simple_university_journal/controllers/home/home_cubit.dart';
import 'package:simple_university_journal/controllers/home/home_state.dart';
import 'package:simple_university_journal/resources/strings.dart';
import 'package:simple_university_journal/view/pages/groups_page.dart';
import 'package:simple_university_journal/view/widgets/add_list_item_widget.dart';
import 'package:simple_university_journal/view/widgets/list_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit cubit;

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    cubit.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(StringResource.home.title),
        centerTitle: false,
        actions: [
          AddListItemWidget(
            onDone: (value) {
              if (value.isNotEmpty) {
                cubit.addSubject(value);
              }
            },
          )
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSuccessState) {
            return ListView.builder(
              itemCount: state.subjects.length,
              itemBuilder: (context, index) {
                final subject = state.subjects[index];
                return ListTileWidget(
                  key: ValueKey(index),
                  title: subject,
                  onDelete: () {
                    cubit.deleteSubject(index);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => GroupsCubit(),
                          child: GroupsPage(
                            title: subject,
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
