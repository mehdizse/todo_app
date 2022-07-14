import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_app/screens/todo_screen.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'shared/bloc_observer.dart';

void main() {
  initializeDateFormatting('fr', null);
  BlocOverrides.runZoned(
        () {
      TodoCubit();
    },
    blocObserver: MyBlocObserver(),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Default Parameter",
      home:TodoScreen(),
    );
  }

}

