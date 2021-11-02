import 'package:bloc_todo_app/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:bloc_todo_app/widgets/login_button.dart';
import 'package:bloc_todo_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginBody extends StatefulWidget {
  final UserRepository userRepository;

  LoginBody({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState(userRepository);
}

class _LoginBodyState extends State<LoginBody> {
  final UserRepository userRepository;

  _LoginBodyState(this.userRepository);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        if (state is UserLoginFailure) {
          Fluttertoast.showToast(msg: "Error loggin in");
        }
      },
      child: BlocBuilder<UserLoginBloc, UserLoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        // ignore: missing_return
                        textValidator: (value) {
                          if (value.isEmpty) {
                            return 'username cant be empty';
                          } else if (value.length < 4) {
                            return 'Minimum is 4 characters';
                          }
                        },
                        labelText: "Enter your username",
                        textEditingController: usernameController,
                        isPassword: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        labelText: 'Enter your password',
                        textEditingController: passwordController,
                        isPassword: true,
                        // ignore: missing_return
                        textValidator: (value) {
                          if (value.isEmpty) {
                            return 'password cant be empty';
                          } else if (value.length < 8) {
                            return 'Minimum is 8 characters';
                          }
                        },
                      ),
                    ),
                    state is UserLoginLoading
                        ? Center(
                            child: Text(
                              "Please wait a while...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : LoginButton(
                            onTap: () {
                              if (formKey.currentState.validate()) {
                                print("validate" +
                                    usernameController.text +
                                    passwordController.text);
                                BlocProvider.of<UserLoginBloc>(context).add(
                                  OnUserLoginButtonPressed(
                                    email: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
