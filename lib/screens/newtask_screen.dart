import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/widgets/task_item.dart';


class NewTaskScreen extends StatelessWidget {

  const NewTaskScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){},
        builder: (context,state){
          var tasks = TodoCubit.get(context).newTasks;
          return tasks.length == 0?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Icon(Icons.menu,size: 100,color: Colors.grey,),
                    Text("No tasks add yet please add some taks",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey),),
                  ],
                ),
              )
              : ListView.separated(
              itemBuilder: (context,index) => buildTaskItem(tasks[index],context),
              separatorBuilder: (context,index)=>Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              itemCount: tasks.length);
        },
    );
  }
}
