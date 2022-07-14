import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../screens/archivedtask_screen.dart';
import '../../screens/donetask_screen.dart';
import '../../screens/newtask_screen.dart';

class TodoCubit extends Cubit<TodoStates>{

  int currentIndex = 0;
  late Database database;
  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archviedTasks = [];

  bool open = false;
  List screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];

  List<String> titles = [
    "New Task",
    "Done Task",
    "Archived Task",
  ];

  TodoCubit() : super(TodoInitState());

  static TodoCubit get(context)=>BlocProvider.of(context);

  void changeCurrentIndex(int index){
    currentIndex = index;
    emit(TodoChangeIndexState());
  }

  void createDatabase() async{
    openDatabase(
        "todo.db",
        version: 1,
        onCreate: (database,version){
          print("Database created");
          database.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT, date TEXT,time Text,status Text ) ")
              .then((value){
            print("table created");
          }).catchError((error){
            print("Error when creating table"+error.toString());
          });
        },
        onOpen: (database){
         print("database open");
          getFromDatabase(database);
        }
    ).then((value){
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

  insertToDatabase({required String title, required String time, required String date,}) async{
    await database.transaction((txn){
      return txn.rawInsert("INSERT INTO tasks(title,date,time,status) values('$title','$time','$date','new')")
          .then((value){
        print("value inserted $value successifuly");
        emit(TodoInsertToDatabaseState());
        getFromDatabase(database);
      }).catchError((errors){
        print("Error when insert on table"+errors.toString());
      });
    }).catchError((error){
      print("Error when insert on table"+error.toString());
    });
  }

  void updateDatabase({
    required status,
    required id,
}){
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value){
          emit(TodoUpdateDatabaseState());
          getFromDatabase(database);
    });
  }

  void deleteFromDatabase({
  required int id,
}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value){
      emit(TodoDeleteFromDatabaseState());
      getFromDatabase(database);
    });
  }

  void getFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archviedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value){
      tasks = value;
      tasks.forEach((element){
        if(element["status"]=="new"){
          newTasks.add(element);
        }else if(element["status"]=="done"){
          doneTasks.add(element);
        }else if(element["status"]=="archived"){
          archviedTasks.add(element);
        }
      });
      emit(TodoGetFromDatabaseState());
    });

  }

  void changeOpenBottomSheet(){
    open = !open;
    emit(TodoChangeIndexState());
  }
}