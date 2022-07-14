import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';


Widget buildTaskItem(Map model,BuildContext context)=> Dismissible(
  key: Key(model["id"].toString()),
  onDismissed: (direction){
    TodoCubit.get(context).deleteFromDatabase(id: model["id"]);
  },
  child:   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
                model["date"]
            ),
          ),
          const SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  model["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model["time"],
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20,),
          IconButton(
            onPressed:(){
              TodoCubit.get(context).updateDatabase(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box),
             color: Colors.green,
          ),
          IconButton(
            onPressed:(){
              TodoCubit.get(context).updateDatabase(status: 'archived', id: model['id']);
            },
            icon: Icon(Icons.archive),
            color: Colors.grey,
          ),
        ],
      ),
    ),
);
