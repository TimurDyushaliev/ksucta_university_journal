import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_university_journal/controllers/auth/auth_cubit.dart';
import 'package:simple_university_journal/services/hive_provider.dart';
import 'package:simple_university_journal/view/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveProvider.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthCubit(),
        child: const AuthPage(),
      ),
    );
  }
}
