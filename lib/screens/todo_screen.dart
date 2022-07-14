import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/widgets/bottom_sheet.dart';



class TodoScreen extends StatelessWidget {


  TimeOfDay timeOfDay = TimeOfDay.now();


  var scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit,TodoStates>(
        listener: (BuildContext context, TodoStates state) {  },
        builder: (BuildContext context, state) {
          TodoCubit cubit = TodoCubit.get(context);
          var tasks = cubit.tasks;
          return  Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu),label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.task_alt_sharp),label: "Done"),
                BottomNavigationBarItem(icon: Icon(Icons.archive),label: "Archived"),
              ],
              onTap: (value){
                  cubit.changeCurrentIndex(value);
              },
            ),
            floatingActionButton: cubit.currentIndex == 0?bottomSheet(
                cubit: cubit,
                title: title,
                time: time,
                date: date,
                scaffoldKey: scaffoldKey,
                context: context):Container(),
          );
        },

      ),
    );
  }





}

