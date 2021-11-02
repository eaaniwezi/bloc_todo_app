import 'package:bloc_todo_app/bloc/language_bloc/language_bloc.dart';
import 'package:bloc_todo_app/bloc/task_bloc/tasks_bloc.dart';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth.dart';
import 'package:bloc_todo_app/repositories/app_localization.dart';
import 'package:bloc_todo_app/screens/home_screen/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/models/task.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final int _startingTabCount = 4;
  List<Tab> _tabsHeader = [];
  TabController _tabController;

  String lang = "English 🇬🇧";
  List languages = ["English 🇬🇧", "Русский 🇷🇺", "Français 🇫🇷"];

  void initState() {
    BlocProvider.of<TasksBloc>(context).add(FetchData());
    BlocProvider.of<LanguageBloc>(context)
        .add(LoadLanguage(locale: Locale('en', 'US')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabsHeader = [
      Tab(
        height: 70,
        text: AppLocalization.of(context).getTranslatedValues('On_hold'),
      ),
      Tab(
        height: 70,
        text: AppLocalization.of(context).getTranslatedValues('In_progress'),
      ),
      Tab(
        height: 70,
        text: AppLocalization.of(context).getTranslatedValues('Needs_review'),
      ),
      Tab(
        height: 70,
        text: AppLocalization.of(context).getTranslatedValues('Approved_Tasks'),
      ),
    ];
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          List<Task> tasks = state.task;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
              length: _startingTabCount,
              child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade900,
                  actions: [
                    Padding(
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
                    // DropdownButton(
                    //   dropdownColor: Colors.teal,
                    //   underline: SizedBox(),
                    //   value: lang,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       if (value == "Français 🇫🇷") {
                    //         print(value);
                    //         BlocProvider.of<LanguageBloc>(context)
                    //           ..add(LoadLanguage(locale: Locale('fr', '')));
                    //       } else if (value == "English 🇬🇧") {
                    //         print(value);
                    //         BlocProvider.of<LanguageBloc>(context)
                    //           ..add(LoadLanguage(locale: Locale('en', 'EN')));
                    //       } else if (value == "Русский 🇷🇺") {
                    //         print(value);
                    //         BlocProvider.of<LanguageBloc>(context)
                    //           ..add(LoadLanguage(locale: Locale('ru', 'RU')));
                    //       }
                    //       lang = value;
                    //     });
                    //   },
                    //   items: languages.map((value) {
                    //     return DropdownMenuItem(
                    //       value: value,
                    //       child: Text(
                    //         value,
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Align(
                            child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  BlocProvider.of<UserAuthBloc>(context).add(
                                    UserIsLoggedOut(),
                                  );
                                }),
                          ),
                        ),
                      ),
                    )
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.teal,
                    tabs: _tabsHeader,
                    controller: _tabController,
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  children: _generalWidgets(tasks),
                ),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  _generalWidgets(List<Task> tasks) {
    return [
      SingleChildScrollView(
        child: _getTaskList(tasks, "0"),
      ),
      SingleChildScrollView(
        child: _getTaskList(tasks, "1"),
      ),
      SingleChildScrollView(
        child: _getTaskList(tasks, "2"),
      ),
      SingleChildScrollView(
        child: _getTaskList(tasks, "3"),
      ),
    ];
  }

  _getTaskList(List<Task> tasks, String id) {
    List<Task> row = tasks.where((t) => t.row == id).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: row.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskItem(task: row[index]);
      },
    );
  }
}
