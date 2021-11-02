import 'package:bloc_todo_app/bloc/task_bloc/tasks_bloc.dart';
import 'package:bloc_todo_app/bloc/user_auth_bloc/user_auth.dart';
import 'package:bloc_todo_app/screens/home_screen/task_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_app/models/task.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final int _startingTabCount = 4;
  // ignore: deprecated_member_use
  List<Tab> _tabsHeader = [];
  TabController _tabController;
  void initState() {
    BlocProvider.of<TasksBloc>(context).add(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabsHeader = [
      Tab(text: "On\nhold"),
      Tab(text: "In\nprogress"),
      Tab(text: "Needs\nreview"),
      Tab(text: "Approved\nTasks"),
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
                drawer: Drawer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ),
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey.shade900,
                  title: Text("Kanban"),
                  actions: [
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
