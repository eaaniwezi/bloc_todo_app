
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i18n_extension/i18n_widget.dart';
// import 'package:bloc_todo_app/bloc/auth_bloc/auth_bloc.dart';
// import 'package:bloc_todo_app/bloc/auth_bloc/auth_event.dart';
// import 'package:bloc_todo_app/bloc/main_bloc/main_bloc.dart';
// import 'package:bloc_todo_app/models/task.dart';
// import 'package:bloc_todo_app/screens/main_screen/task_item.dart';
// import 'package:bloc_todo_app/utils/color.dart';
// import 'package:bloc_todo_app/utils/translate.dart';

// enum SingingCharacter { ru, eng }

// class MainPage extends StatefulWidget {

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {

//   final int _startingTabCount = 4;
//   List<Tab> _tabs = List<Tab>();
//   TabController _tabController;
//   SingingCharacter _character = SingingCharacter.ru;

//   void initState() {
//     BlocProvider.of<MainBloc>(context).add(GetData());
//     super.initState();
//   }

//   _generalWidgets(List<Task> tasks){
//    return [
//      SingleChildScrollView(child: _getTaskList(tasks, "0"),),
//      SingleChildScrollView(child: _getTaskList(tasks, "1"),),
//      SingleChildScrollView(child: _getTaskList(tasks, "2"),),
//      SingleChildScrollView(child: _getTaskList(tasks, "3"),),
//    ];

//   }

//   _getTaskList(List<Task> tasks, String id){
//     List<Task> row = tasks.where((t) => t.row == id ).toList();
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: row.length,
//       itemBuilder: (BuildContext context, int index) {
//         return TaskItem(task:row[index]);
//       },
//     );


//   }
  
//   @override
//   Widget build(BuildContext context) {
//     _tabs = [
//       Tab(text: "On\nhold".i18n),
//       Tab(text: "In\nprogress".i18n),
//       Tab(text: "Needs\nreview".i18n),
//       Tab(text: "Approved\nTasks".i18n),
//     ];
//     return  BlocBuilder<MainBloc, MainState>(
//       builder: (context, state) {
//         if(state is MainLoaded){

//           List<Task> tasks = state.task;

//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: DefaultTabController(
//               length: _startingTabCount,
//               child: Scaffold(
//                 drawer: Drawer(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       ListTile(
//                         title: const Text('Russian'),
//                         leading: Radio(
//                           activeColor: Colors.teal,
//                           value: SingingCharacter.ru,
//                           groupValue: _character,
//                           onChanged: (SingingCharacter value) {
//                             setState(() {
//                               _character = value;
//                              if(value  == SingingCharacter.ru ){ I18n.of(context).locale = Locale('ru');}
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: const Text('English'),
//                         leading: Radio(
//                           activeColor: Colors.teal,
//                           value: SingingCharacter.eng,
//                           groupValue: _character,
//                           onChanged: (SingingCharacter value) {
//                             setState(() {
//                               _character = value;
//                               if(value  == SingingCharacter.eng ){ I18n.of(context).locale = Locale('eng');}
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                   backgroundColor: AppColor.black1,
//                   appBar: AppBar(
//                     backgroundColor: AppColor.black2,
//                     title: Text("Kanban"),
//                     actions: [
//                       IconButton(icon: Icon(EvaIcons.logOutOutline), onPressed: () {
//                         BlocProvider.of<AuthenticationBloc>(context).add(
//                           LoggedOut(),
//                         );
//                       })
//                     ],
//                     bottom: TabBar(
//                       indicatorColor: Colors.teal,
//                       tabs: _tabs,
//                       controller: _tabController,
//                     ),
//                   ),
//                   body: TabBarView(
//                   controller: _tabController,
//                   children: _generalWidgets(tasks),
//                 ),
//               ),
//             ),);
//         }
//         return Center(child: CircularProgressIndicator());
//       },
//     );

//   }
// }