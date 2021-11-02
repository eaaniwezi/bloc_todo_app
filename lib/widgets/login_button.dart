import 'package:bloc_todo_app/repositories/app_localization.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onTap;
  const LoginButton({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(onTap:  () {
        onTap();
      },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Colors.teal[200], borderRadius: BorderRadius.circular(25)),
          child:  Center(
            child: Text(
              AppLocalization.of(context).getTranslatedValues('log_in'),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
