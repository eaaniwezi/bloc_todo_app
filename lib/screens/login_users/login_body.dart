import 'package:bloc_todo_app/bloc/language_bloc/language_bloc.dart';
import 'package:bloc_todo_app/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:bloc_todo_app/repositories/app_localization.dart';
import 'package:bloc_todo_app/widgets/login_button.dart';
import 'package:bloc_todo_app/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  String lang = "English 🇬🇧";
  List languages = ["English 🇬🇧", "Русский 🇷🇺", "Français 🇫🇷"];

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
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          dropdownColor: Colors.teal,
                          underline: SizedBox(),
                          icon: Icon(
                                  FontAwesomeIcons.language,
                                  color: Colors.white,
                                ),
                          onChanged: (value) {
                            setState(() {
                              if (value == "Français 🇫🇷") {
                                print(value);
                                BlocProvider.of<LanguageBloc>(context)
                                  ..add(LoadLanguage(locale: Locale('fr', '')));
                              } else if (value == "English 🇬🇧") {
                                print(value);
                                BlocProvider.of<LanguageBloc>(context)
                                  ..add(LoadLanguage(locale: Locale('en', 'EN')));
                              } else if (value == "Русский 🇷🇺") {
                                print(value);
                                BlocProvider.of<LanguageBloc>(context)
                                  ..add(LoadLanguage(locale: Locale('ru', 'RU')));
                              }
                              lang = value;
                            });
                          },
                          items: languages.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        // ignore: missing_return
                        textValidator: (value) {
                          if (value.isEmpty) {
                            return AppLocalization.of(context).getTranslatedValues('empty_username');
                          } else if (value.length < 4) {
                            return AppLocalization.of(context).getTranslatedValues('username_minimum');
                          }
                        },
                        labelText:AppLocalization.of(context).getTranslatedValues('enter_your_username'),
                        textEditingController: usernameController,
                        isPassword: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextWidget(
                        labelText: AppLocalization.of(context).getTranslatedValues('enter_your_password'),
                        textEditingController: passwordController,
                        isPassword: true,
                        // ignore: missing_return
                        textValidator: (value) {
                          if (value.isEmpty) {
                            return AppLocalization.of(context).getTranslatedValues('empty_password');
                          } else if (value.length < 8) {
                            return AppLocalization.of(context).getTranslatedValues('password_minimum');
                          }
                        },
                      ),
                    ),
                    state is UserLoginLoading
                        ? Center(
                            child: Text(
                             AppLocalization.of(context).getTranslatedValues('waiting'),
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
                          ),
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
