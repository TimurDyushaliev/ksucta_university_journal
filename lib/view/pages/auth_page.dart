import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:simple_university_journal/controllers/auth/auth_cubit.dart';
import 'package:simple_university_journal/controllers/auth/auth_state.dart';
import 'package:simple_university_journal/controllers/home/home_cubit.dart';
import 'package:simple_university_journal/resources/strings.dart';
import 'package:simple_university_journal/view/pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final TextEditingController textEditingController;
  late final AuthCubit cubit;

  @override
  void initState() {
    textEditingController = TextEditingController();
    cubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case AuthFailureState:
              MotionToast.error(
                description: Text(
                  StringResource.auth.noSuchUser,
                ),
              ).show(context);
              break;
            case AuthSuccessState:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => HomeCubit(),
                    child: const HomePage(),
                  ),
                ),
              );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 225,
                child: TextField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: StringResource.auth.hintText,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  cubit.validate(textEditingController.text);
                },
                child: Text(StringResource.auth.login),
              )
            ],
          ),
        ),
      ),
    );
  }
}
