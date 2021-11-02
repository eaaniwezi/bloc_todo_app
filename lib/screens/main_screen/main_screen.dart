
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i18n_extension/i18n_widget.dart';
// import 'package:bloc_todo_app/bloc/main_bloc/main_bloc.dart';
// import 'package:bloc_todo_app/repositories/repositories.dart';

// import 'main_page.dart';


// class MainScreen extends StatelessWidget {
//   final UserRepository userRepository;

//     MainScreen({Key key, @required this.userRepository})
//       : assert(userRepository != null),
//         super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<MainBloc>(
//       create: (context) => MainBloc(userRepository: userRepository),
//       child: I18n(initialLocale: Locale('ru', 'eng'), child: MainPage()),
//     );
//   }
// }
