import 'package:bloc_todo_app/bloc/user_login_bloc/user_login_bloc.dart';
import 'package:bloc_todo_app/widgets/login_button.dart';
import 'package:bloc_todo_app/widgets/text_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/repositories/repositories.dart';
import 'package:bloc_todo_app/utils/color.dart';
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
            backgroundColor: AppColor.black1,
            resizeToAvoidBottomInset: false,
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
            // body: Padding(
            //   padding:
            //       const EdgeInsets.only(right: 20.0, left: 20.0, top: 80.0),
            //   child: SingleChildScrollView(
            //     child: Form(
            //       key: formkey,
            //       child: Column(
            //         children: [
            //           Container(
            //               height: 200.0,
            //               padding: EdgeInsets.only(bottom: 20.0, top: 40.0),
            //               child: Text(
            //                 "KANBAN",
            //                 style: TextStyle(
            //                     color: Colors.teal,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 24.0),
            //               )),
            //           SizedBox(
            //             height: 30.0,
            //           ),
            //           TextFormField(
            //             validator: _loginValidate,
            //             style: TextStyle(
            //                 fontSize: 14.0,
            //                 color: Colors.teal,
            //                 fontWeight: FontWeight.bold),
            //             controller: usernameController,
            //             keyboardType: TextInputType.text,
            //             decoration: InputDecoration(
            //               errorBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.red[500], width: 1.0),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               focusedErrorBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.red, width: 1.0),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               prefixIcon:
            //                   Icon(EvaIcons.personOutline, color: Colors.teal),
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.grey),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.teal),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               contentPadding:
            //                   EdgeInsets.only(left: 10.0, right: 10.0),
            //               labelText: "Login",
            //               hintStyle: TextStyle(
            //                   fontSize: 12.0,
            //                   color: Colors.grey,
            //                   fontWeight: FontWeight.w500),
            //               labelStyle: TextStyle(
            //                   fontSize: 12.0,
            //                   color: Colors.grey,
            //                   fontWeight: FontWeight.w500),
            //             ),
            //             autocorrect: false,
            //             onChanged: _validate,
            //           ),
            //           SizedBox(
            //             height: 20.0,
            //           ),
            //           TextFormField(
            //             validator: _passwordValidate,
            //             keyboardType: TextInputType.text,
            //             style: TextStyle(
            //                 fontSize: 14.0,
            //                 color: Colors.teal,
            //                 fontWeight: FontWeight.bold),
            //             controller: passwordController,
            //             decoration: InputDecoration(
            //               errorBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(
            //                       color: Colors.red[500], width: 1.0),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               focusedErrorBorder: OutlineInputBorder(
            //                   borderSide:
            //                       BorderSide(color: Colors.red, width: 1.0),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               fillColor: Colors.white,
            //               prefixIcon: Icon(
            //                 EvaIcons.lockOutline,
            //                 color: Colors.teal,
            //               ),
            //               enabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.grey),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               focusedBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.teal),
            //                   borderRadius: BorderRadius.circular(30.0)),
            //               contentPadding:
            //                   EdgeInsets.only(left: 10.0, right: 10.0),
            //               labelText: "Password",
            //               hintStyle: TextStyle(
            //                   fontSize: 12.0,
            //                   color: Colors.grey,
            //                   fontWeight: FontWeight.w500),
            //               labelStyle: TextStyle(
            //                   fontSize: 12.0,
            //                   color: Colors.grey,
            //                   fontWeight: FontWeight.w500),
            //             ),
            //             autocorrect: false,
            //             obscureText: true,
            //             onChanged: _validate,
            //           ),
            //           SizedBox(
            //             height: 30.0,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.stretch,
            //               children: <Widget>[
            //                 SizedBox(
            //                     height: 45,
            //                     child: state is UserLoginLoading
            //                         ? Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.center,
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             children: <Widget>[
            //                               Center(
            //                                   child: Column(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 children: [
            //                                   SizedBox(
            //                                     height: 25.0,
            //                                     width: 25.0,
            //                                     child:
            //                                         CupertinoActivityIndicator(),
            //                                   )
            //                                 ],
            //                               ))
            //                             ],
            //                           )
            //                         : RaisedButton(
            //                             color: Colors.teal,
            //                             disabledColor: Colors.teal,
            //                             disabledTextColor: Colors.white,
            //                             shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(30.0),
            //                             ),
            //                             onPressed: _onLoginButtonPressed,
            //                             child: Text("LOG IN",
            //                                 style: TextStyle(
            //                                     fontSize: 12.0,
            //                                     fontWeight: FontWeight.bold,
            //                                     color: Colors.white)))),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }

  void _onLoginButtonPressed() {
    BlocProvider.of<UserLoginBloc>(context).add(
      OnUserLoginButtonPressed(
        email: usernameController.text,
        password: passwordController.text,
      ),
    );
  }
}
